
resource "aws_lambda_event_source_mapping" "sqs_event_source_mapping" {
  count            = var.subscribe_to_queue ? 1 : 0
  event_source_arn = var.subscribing_queue_arn
  function_name    = aws_lambda_function.lambda.function_name
  batch_size       = var.sqs_batch_size
}
