import boto3
import logging
import os
from io import BytesIO
from PIL import Image

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    logger.info(f"event: {event}")
    logger.info(f"context: {context}")
    
    bucket = event["Records"][0]["s3"]["bucket"]["name"] 
    key = event["Records"][0]["s3"]["object"]["key"]
    
    thumbnail_bucket = os.environ["dest_bucket"]
    thumbnail_name, thumbnail_ext = os.path.splitext(key)
    thumbnail_key = f"{thumbnail_name}_thumbnail{thumbnail_ext}"
    
    file = s3_client.get_object(Bucket=bucket, Key=key)['Body'].read()
    img = Image.open(BytesIO(file))
    
    img.thumbnail((500, 500))
    
    buffer = BytesIO()
    img.save(buffer, "JPEG")
    buffer.seek(0)
    
    sent_data = s3_client.put_object(Bucket=thumbnail_bucket, Key=thumbnail_key, Body=buffer)
    
    if sent_data['ResponseMetadata']['HTTPStatusCode'] != 200:
        raise Exception('Failed to upload image {} to bucket {}'.format(key, bucket))
    
    return event
    
    