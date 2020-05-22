output "rt_output" {
  value       = azurerm_route_table.rt_obj
  description = "Route table object"
}

output "routes_output" {
  value = lookup(module.routes.routes_output, "routes_output", {})
  description = "Map of Routes."
}

