output "function_app_default_hostname" {
  value = azurerm_linux_function_app.function_app.default_hostname
}

output "function_url" {
  value = "${azurerm_linux_function_app.function_app.default_hostname}/api/main"
}
