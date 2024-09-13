resource "aws_iam_policy" "lambda-policy-buckets" {
    name = "LambdaS3policy"
    policy = jsonencode({
        Version = "2012-10-27"
        Statement = [{
            "Effect": "Allow"
            "Action": "s3:GetObjects"
            "Resource": "${aws_s3_bucket.source_bucket.arn}/*"
    },  {
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.dest_bucket.arn}/*"
        }]
    })
}