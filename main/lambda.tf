data "archive_file" "thumbnail_lambda_source_archive" { # compactando o arquivo em ZIP para que o AWS Lambda aceite
  type        = "zip"
  source_dir  = "${path.module}/lambda_code"
  output_path = "${path.module}/my-lambda-function.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "${path.module}/my-lambda-function.zip"
  function_name    = "Thumbnail-Lambda-Function"
  role             = aws_iam_role.role_for_lambda.arn
  description      = "Lambda Function used to generate thumbnail image"
  source_code_hash = data.archive_file.thumbnail_lambda_source_archive.output_base64sha256
  runtime          = "python3.12"
  memory_size      = 256
  timeout          = 300
  handler          = "lambdaFunction.lambda_handler" # função lambda que vai ser usada

  layers = [
    "arn:aws:lambda:sa-east-1:770693421928:layer:Klayers-p312-Pillow:2"
  ]

  environment {
    variables = {
      dest_bucket = aws_s3_bucket.dest_bucket.bucket
    }
  }
}

resource "aws_lambda_permission" "thumbnail_s3_lambda_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "s3.amazonaws.com"
  action        = "lambda:InvokeFunction"
  source_arn    = aws_s3_bucket.source_bucket.arn
}

resource "aws_s3_bucket_notification" "source_bucket_notification" {
  bucket = aws_s3_bucket.source_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_lambda_permission.thumbnail_s3_lambda_permission]
}