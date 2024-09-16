data "archive_file" "thumbnail_lambda_source_archive" { # compactando o arquivo em ZIP para que o AWS Lambda aceite
  type        = "zip"
  source_file = "${path.module}/main/lambda_code"
  output_path = "${path.module}/main/my-lambda-function.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "${path.module}/main/my-lambda-function.zip"
  function_name    = "Thumbnail-Lambda-Function"
  role             = aws_iam_role.role_for_lambda.arn
  description      = "Lambda Function used to generate thumbnail image"
  source_code_hash = data.archive_file.thumbnail_lambda_source_archive.output_base64sha256
  runtime          = "python3.12"
  memory_size      = 256
  timeout          = 300
  handler          = "lambdaFunction.lambda_handler" # função lambda que vai ser usada
}