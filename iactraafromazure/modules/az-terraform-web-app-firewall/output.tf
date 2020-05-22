output "azurerm_application_gateway" {
  description = "List of azurerm_application_gateway"
  value = azurerm_application_gateway.waf
}

output "diagnostic_log" {
  description = "The list of diagnostics created"
  value = module.diagnostics
}