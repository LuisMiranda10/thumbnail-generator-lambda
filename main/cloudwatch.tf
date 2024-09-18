resource "aws_cloudwatch_log_group" "cloudwatch_logs_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days = 30

  tags = merge(local.common_tags, {
    name = "${local.namespaced_service_name}-cloudwatch-log-lambda"
  })
}