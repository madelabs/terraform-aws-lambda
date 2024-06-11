module "lambda" {
  source = "/Users/user2/Documents/GitHub/kehe/terraform-aws-lambda"

  function_name        = "hello-world"
  function_description = "Hello World"
  function_handler     = "placeholder::placeholder.Function::FunctionHandler"

  function_runtime = "dotnet6"


  vpc_config = {
    subnet_ids         = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]
    security_group_ids = ["sg-0123456789abcdef0"]
  }

  lambda_environment_variables = {
    variables = {
      "ASPNETCORE_ENVIRONMENT" = "Development"
      "TESTBED"                = "true"
    }
  }
}
