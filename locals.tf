locals {
  dotnet6_placeholder  = "placeholder-csharp.zip"
  nodejs18_placeholder = "placeholder-js.zip"
  python3_placeholder  = "placeholder-python3.zip"

  placeholder = lookup(
    {
      "dotnet6"    = local.dotnet6_placeholder
      "nodejs18.x" = local.nodejs18_placeholder
      "python3.x"  = local.python3_placeholder
    }, var.function_runtime, null
  )
}
