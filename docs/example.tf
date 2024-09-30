module "lambda" {
  source = "../"
  # version              = "0.0.3"
  function_name        = "hello-world"
  function_description = "Hello World"
  function_handler     = "placeholder::placeholder.Function::FunctionHandler"

  function_runtime = "dotnet8"
  enable_xray      = true

  vpc_config = {
    subnet_ids         = ["subnet-03c657c8cd97f307b"]
    security_group_ids = ["sg-0fb4ba8549e60d174"]
  }

  lambda_environment_variables = {
    variables = {
      "ASPNETCORE_ENVIRONMENT" = "Development"
      "TESTBED"                = "true"
    }
  }
  permissions_boundary = "arn:aws:iam::171549778621:policy/Boundary_TFCDeployment"
  tags                 = { env = "net8" }
}
