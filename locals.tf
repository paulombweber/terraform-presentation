locals {
  function_app_name         = var.function_app_name
  service_plan_name         = "${var.function_app_name}-plan"
  application_insights_name = "${var.function_app_name}-application-insights"
  storage_account_name      = "appsta${formatdate("YYYYMMDDhhmmss", timestamp())}"

  stack_tags = merge(var.tags, {
    FunctionAppName = local.function_app_name,
    ResourceGroup   = var.resource_group_name
  })
}


