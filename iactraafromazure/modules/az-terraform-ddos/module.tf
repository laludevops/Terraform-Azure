resource "azurerm_network_ddos_protection_plan" "ddos_obj" {
  name                = module.ddos_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.ddos_name.naming_convention_output[var.naming_convention_info.name].tags.0
}
