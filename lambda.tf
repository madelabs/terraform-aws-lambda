resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  description   = var.function_description
  handler       = var.lambda_package_type != "Image" ? var.function_handler : null
  package_type  = var.lambda_package_type
  filename      = var.lambda_package_type != "Image" && local.placeholder != null ? "${path.module}/placeholders/${local.placeholder}" : null
  memory_size   = var.function_memory
  timeout       = var.function_timeout_seconds
  runtime       = var.lambda_package_type != "Image" ? var.function_runtime : null
  image_uri     = var.lambda_package_type == "Image" ? var.lambda_image_uri : null


  ephemeral_storage {
    size = var.function_ephemeral_storage
  }

  dynamic "environment" {
    for_each = var.lambda_environment_variables == null ? [] : [var.lambda_environment_variables]
    content {
      variables = environment.value.variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  tracing_config {
    mode = var.enable_xray ? "Active" : "PassThrough"
  }

  tags = var.tags
}
