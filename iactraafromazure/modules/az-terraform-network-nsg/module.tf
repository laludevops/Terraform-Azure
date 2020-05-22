resource "azurerm_network_security_group" "nsg_obj" {
  for_each                = var.nsg_info
  name                    = module.nsg_name.naming_convention_output[each.key].names.0
  resource_group_name     = var.resource_group_name
  location                = var.location
  tags                    = module.nsg_name.naming_convention_output[each.key].tags.0
  depends_on              = [var.dependencies]
}
