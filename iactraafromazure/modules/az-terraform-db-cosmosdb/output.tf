output "azurerm_cosmosdb_account" {
  description = "The list of postgresql server resource"
  value       = azurerm_cosmosdb_account.account
}

output "diagnostic_log" {
  description = "The list of diagnostics created"
  value = module.diagnostics
}
