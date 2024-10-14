locals {
  role_name = "${var.function_name}-lambda-role"
}

resource "aws_iam_role" "lambda_role" {
  name                 = local.role_name
  assume_role_policy   = data.aws_iam_policy_document.lambda_assume_role_policy.json
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_sqs_policy" {
  count       = var.subscribe_to_queue ? 1 : 0
  name        = "${var.function_name}-queue-policy"
  description = "Policy to allow the function ${var.function_name} to consume messages."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
        ],
        Effect   = "Allow",
        Resource = var.subscribing_queue_arn,
      },
    ],
  })
}


resource "aws_iam_policy" "lambda_secret_policy" {
  count       = var.has_secret ? 1 : 0
  name        = "${var.function_name}-secret-policy"
  description = "Policy to allow the function ${var.function_name} to use a secret."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
        ],
        Effect   = "Allow",
        Resource = var.secret_arn,
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "att_secret_policy" {
  count      = var.has_secret ? 1 : 0
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_secret_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "att_sqs_execution" {
  count      = var.subscribe_to_queue ? 1 : 0
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_sqs_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "att_basic_execution" {
  count      = var.enable_logs ? 1 : 0
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "att_vpc_execution" {
  count      = var.vpc_config != null ? 1 : 0
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "att_lambda_xray" {
  count      = var.enable_xray == true ? 1 : 0
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "att_extra_permissions" {
  for_each   = var.extra_permissions_policy_arns
  role       = aws_iam_role.lambda_role.name
  policy_arn = each.value
}
