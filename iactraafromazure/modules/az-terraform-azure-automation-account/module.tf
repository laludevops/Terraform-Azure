resource "azurerm_automation_account" "azau_obj" {
  name                = module.azau_name.naming_convention_output["${var.naming_convention_info.name}"].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.azau_name.naming_convention_output["${var.naming_convention_info.name}"].tags.0
  
  sku_name = var.sku
}