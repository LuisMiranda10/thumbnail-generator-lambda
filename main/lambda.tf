resource "aws_lambda_function" "lambda_function" {
  filename      = ""
  function_name = ""
  role          = aws_iam_role.role_for_lambda
}