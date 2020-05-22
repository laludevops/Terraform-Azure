resource "azurerm_recovery_services_vault" "rsv_obj" {
  name                = module.rsv_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  # soft_delete_enabled = var.enable_soft_delete
  tags                = module.rsv_name.naming_convention_output[var.naming_convention_info.name].tags.0
}


