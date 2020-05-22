data "azurerm_virtual_network" "data_vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
}
