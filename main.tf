data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type

  tags = merge(local.stack_tags, tomap({ "environment" = var.environment }), tomap({ "release" = var.release }))
}


// App Service Plan
resource "azurerm_service_plan" "service_plan" {
  name                = local.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Y1"
  os_type             = "Linux"

  tags = local.stack_tags
}

// Application Insights
resource "azurerm_application_insights" "application_insights" {
  name                = local.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "Node.JS"
  retention_in_days   = var.application_insights_retention_days

  tags = local.stack_tags
}

// Function App
resource "azurerm_linux_function_app" "function_app" {
  name                       = local.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id

  https_only = true

  app_settings = merge(var.app_settings, {
    "WEBSITE_RUN_FROM_PACKAGE"       = "1",
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = true
  })

  site_config {
    http2_enabled     = true
    use_32_bit_worker = false

    application_insights_key               = azurerm_application_insights.application_insights.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.application_insights.connection_string


    application_stack {
      node_version = var.nodejs_version
    }

    app_service_logs {
      retention_period_days = var.logs_retention_days
    }
  }


  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }

  tags = local.stack_tags

  depends_on = [
    azurerm_service_plan.service_plan,
    azurerm_storage_account.storage_account,
    azurerm_application_insights.application_insights
  ]
}
