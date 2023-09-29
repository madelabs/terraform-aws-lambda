# terraform-aws-lambda

<!-- BEGIN MadeLabs Header -->
![MadeLabs is for hire!](https://d2xqy67kmqxrk1.cloudfront.net/horizontal_logo_white.png)
MadeLabs is proud to support the open source community with these blueprints for provisioning infrastructure to help software builders get started quickly and with confidence. 

We're also for hire: [https://www.madelabs.io](https://www.madelabs.io)

<!-- END MadeLabs Header -->

A Terraform module for managing a zip-file based Lambda function.

This module will create the lambda and an IAM role that can execute the lambda.  It uses a "placeholder" deployment file for initial setup, and then the source code can be updated using the aws cli command `aws lambda update-function-code` to deploy from a separate system.

## Supported Versions and Runtimes

The table below details the runtimes and versions that are supported by this module.  When chosing a runtime, a placeholder file will also be required.  The table shows these filenames.  The values are placed into the `function_runtime_object` variable.

| Name          | Identifier    | Placeholder Filename      |
| ---           | ---           | ---                       |
| Node.js 18    | `nodejs18.x`  | `placeholder-js.zip`      |
| .NET 6        | `dotnet6`     | `placeholder-csharp.zip`  |

## Usage

Example usage for a C# .NET 6 Lambda

```terraform

module "my-lambda" {
  # source = TO BE UPDATED
  # version = TO BE UPDATED

  function_name        = "name-of-lambda"
  function_description = "Lambda's purpose and description"
  function_handler     = "placeholder::placeholder.Function::FunctionHandler"
  function_runtime_object = {
    runtime              = "dotnet6"
    placeholder_filename = "placeholder-csharp.zip"
  }
}
```

### Important note on `function_handler` variable

The `function_handler` variable tells the Lambda where the entrypoint to your code is.  **For the initial deployment, this should point to the entrypoint of the placeholder as detailed below**, otherwise there will be a validation error.  Once separate source code is being deployed to this function, the variable should point to the entrypoint of that separate code.

| Placeholder Filename      | `function_handler` value                              |
| ---                       | ---                                                   |
| `placeholder-js.zip`      | `index.handler`                                       |
| `placeholder-csharp.zip`  | `placeholder::placeholder.Function::FunctionHandler`  |


### Information on lambda code updates

To use this module to manage a lambda, use the following conventions.  This assumes the lambda is included in a repo along-side other code.

Create a `lambda-` prefixed folder that will contain the source code and Terraform.

Create a `src` folder within that folder that contains the source code and build information (such as a buildspec if CodeBuild is being used).

Create a `terraform` folder within the top level folder that will house any Terraform files, separated into folders for each deployed environment.  e.g. `prod`, `uat`, etc.

When the module is first deployed, placeholder "hello world" code will be deployed.  After that, it is up to the build process contained within the `src` folder to update the code.  The current way to do this is with an AWS CLI command, such as [`aws lambda update-function-code`](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-code.html) command from a build process.  This will update the lambda's code with a provided zip file of the compiled code.

Example folder structure:

```plaintext
/project-root
  /lambda-function-example
    /src
    /terraform
      /prod
      /uat
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_iam_policy_document.lambda_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of what your Lambda Function does. | `string` | n/a | yes |
| <a name="input_function_handler"></a> [function\_handler](#input\_function\_handler) | Function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Unique name for your Lambda Function. | `string` | n/a | yes |
| <a name="input_function_runtime_object"></a> [function\_runtime\_object](#input\_function\_runtime\_object) | An object selecting the Lambda runtime and its associated placeholder. | <pre>object({<br>    runtime              = string<br>    placeholder_filename = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->