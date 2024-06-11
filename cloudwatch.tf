resource "aws_cloudwatch_log_group" "function_log_group" {
  count             = var.enable_logs == true ? 1 : 0
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = var.logs_retention_days
}
