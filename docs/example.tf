module "lambda" {
  source               = "madelabs/lambda/aws"
  version              = "0.0.2"
  function_name        = "hello-world"
  function_description = "Hello World"
  function_handler     = "placeholder::placeholder.Function::FunctionHandler"

  function_runtime = "dotnet6"
  enable_xray      = true

  vpc_config = {
    subnet_ids         = ["subnet-id"]
    security_group_ids = ["sg-id"]
  }

  lambda_environment_variables = {
    variables = {
      "ASPNETCORE_ENVIRONMENT" = "Development"
      "TESTBED"                = "true"
    }
  }
  permissions_boundary = "Boundary role arn"
}
