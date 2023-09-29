locals {
  dotnet6_placeholder  = "placeholder-csharp.zip"
  nodejs18_placeholder = "placeholder-js.zip"

  placeholder = lookup(
    {
      "dotnet6"  = local.dotnet6_placeholder
      "nodejs18" = local.nodejs18_placeholder
    }, var.function_runtime, null
  )
}
