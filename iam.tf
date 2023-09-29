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
