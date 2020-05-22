output "redis_firewall" {
  description = "List of firewall rule"
  value = azurerm_redis_firewall_rule.redis_firewall
}

output "redis_standard" {
  value = azurerm_redis_cache.redis_standard
}

output "diagnostic_log" {
  description = "The list of diagnostics created"
  value = module.diagnostics
}