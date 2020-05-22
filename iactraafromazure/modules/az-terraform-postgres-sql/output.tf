output "azurerm_postgresql_server" {
  description = "The list of postgresql server resource"
  value       = azurerm_postgresql_server.server
}

output "postgresql_database" {
  description = "The list of all database resource"
  value       = azurerm_postgresql_database.dbs
}

output "firewall_rule" {
  description = "The list of all firewall rule resource"
  value       = azurerm_postgresql_firewall_rule.firewall_rules
}

output "vnet_rule" {
  description = "The list of all vnet rule resource"
  value       = azurerm_postgresql_virtual_network_rule.vnet_rules
}

output "diagnostic_log" {
  description = "The list of diagnostics created"
  value = module.diagnostics
}
