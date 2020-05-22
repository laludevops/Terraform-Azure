resource "azurerm_network_watcher" "netwatcher" {
  name                = module.nw_name.naming_convention_output.nw.names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.nw_name.naming_convention_output.nw.tags
}



