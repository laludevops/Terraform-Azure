output "acr_output" {
  value = azurerm_container_registry.acr_obj
}

output "admin_username" {
  value = azurerm_container_registry.acr_obj.admin_username
}

output "admin_password" {
  value = azurerm_container_registry.acr_obj.admin_password
}
