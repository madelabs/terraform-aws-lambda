
resource "aws_lambda_event_source_mapping" "sqs_event_source_mapping" {
  count            = length(var.subscribing_queue_arn) == 0 ? 0 : 1
  event_source_arn = var.subscribing_queue_arn
  function_name    = aws_lambda_function.lambda.function_name
  batch_size       = var.sqs_batch_size
}
