output "apim_list" {
    value = azurerm_api_management.api_management
}

output "diagnostic_log" {
  description = "The list of diagnostics created"
  value = module.diagnostics
}