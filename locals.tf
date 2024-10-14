locals {
  dotnet6_placeholder  = "placeholder-csharp-dotnet6.zip"
  dotnet8_placeholder  = "placeholder-csharp-dotnet8.zip"
  nodejs18_placeholder = "placeholder-js.zip"
  python3_placeholder  = "placeholder-python3.zip"

  placeholder = (
    var.function_runtime != null
    ? lookup(
      {
        "dotnet6"    = local.dotnet6_placeholder,
        "dotnet8"    = local.dotnet8_placeholder,
        "nodejs18.x" = local.nodejs18_placeholder,
        "python3.10" = local.nodejs18_placeholder,
        "python3.x"  = local.python3_placeholder
    }, var.function_runtime, null)
    : null
  )
}
