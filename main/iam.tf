resource "aws_iam_policy" "lambda-policy-buckets" {
    name = "LambdaS3policy"
    policy = jsonencode({
        Version = "2012-10-27"
        Statement = [{
            Effect: "Allow"
            Action: "s3:GetObjects"
            Resource: "${aws_s3_bucket.source_bucket.arn}/*"
    },  {
            Effect: "Allow",
            Action: "s3:PutObject",
            Resource: "${aws_s3_bucket.dest_bucket.arn}/*"
        }]
    })
}

resource "aws_iam_role" "role_for_lambda" {
    name = "LambdaRole"
    assume_role_policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }]
    })
    tags = merge(local.common_tags, {
        tag-key = "${namespaced_service_name}-role-lambda"
    })
}

