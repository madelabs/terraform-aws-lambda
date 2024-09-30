variable "function_name" {
  type        = string
  description = "Unique name for your Lambda Function."
}

variable "function_description" {
  type        = string
  description = "Description of what your Lambda Function does."
}

variable "function_handler" {
  type        = string
  description = "Function entrypoint in your code."
  default     = ""
}

variable "function_runtime" {
  type        = string
  description = "An object selecting the Lambda runtime and its associated placeholder.  Must be: (dotnet6|dotnet8|nodejs18.x|python3.x)"
  default     = ""
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of the policy that is used to set the permissions boundary for the role."
  default     = ""
}

variable "subscribing_queue_arn" {
  type        = string
  description = "If the lambda subscribes to a queue, use this variable to inform the SQS object arn."
  default     = null
}

variable "secret_arn" {
  type        = string
  description = "If the lambda uses a secret, use this variable to add the secret arn to the secret policy."
  default     = null
}

variable "subscribe_to_queue" {
  type        = bool
  description = "Whether the lambda will subscribe to a queue or not."
  default     = false
}

variable "has_secret" {
  type        = bool
  description = "Whether the lambda will need access to a secret."
  default     = false
}

variable "sqs_batch_size" {
  type        = number
  description = "In case the lambda subscribes to a queue, refers to the number of messages that Lambda retrieves and processes from an SQS queue in a single invocation. This parameter allows you to control how many messages are processed in a single Lambda function execution."
  default     = 1
}

variable "enable_logs" {
  type        = bool
  description = "Enable CloudWatch Logs for the Lambda Function."
  default     = false
}

variable "vpc_config" {
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  description = "VPC configuration for your Lambda Function."
  default     = null
}

variable "lambda_environment_variables" {
  type = object({
    variables = map(string)
  })
  description = "Values for environment variables that are accessible from function code during execution."
  default     = null
}

variable "logs_retention_days" {
  type        = number
  description = "How many days aws should keep the logs of this function."
  default     = 14
}

variable "lambda_package_type" {
  type        = string
  description = "Value for package_type in aws_lambda_function resource."
  default     = "Zip"
}

variable "function_ephemeral_storage" {
  type        = number
  description = "Size of the /tmp directory in MB available to your Lambda Function."
  default     = 512
}

variable "function_memory" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default     = 128
}

variable "function_timeout_seconds" {
  type        = number
  description = "Amount of time your Lambda Function has to run in seconds."
  default     = 10
}

variable "extra_permissions_policy_arns" {
  type        = set(string)
  description = "List of policy arns you need to add the function role. Should be used for preexisting policies, not managed by this module."
  default     = []
}

variable "enable_xray" {
  description = "Enable X-Ray tracing for the Lambda function."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags that will be assigned to the lambda resource."
  type        = map(string)
  default     = {}
}

variable "lambda_image_uri" {
  type        = string
  description = "Use this variable when using a container based lambda, this is the string for the image uri"
  default     = null
}