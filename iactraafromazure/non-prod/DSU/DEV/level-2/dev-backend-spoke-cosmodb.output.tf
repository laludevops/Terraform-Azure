output "dev_backend_cosmosdb_azurerm_cosmosdb_account" {
  description = "azurerm_cosmosdb_account"
  value = module.dev_backend_cosmosdb_cosmosdb.azurerm_cosmosdb_account
}

output "dev_backend_cosmosdb_diagnostic_log" {
  description = "diagnostic_log"
  value = module.dev_backend_cosmosdb_cosmosdb.diagnostic_log
}