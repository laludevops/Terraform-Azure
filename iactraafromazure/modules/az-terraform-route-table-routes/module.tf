resource "azurerm_route_table" "rt_obj" {
  name                          = module.rt_name.naming_convention_output[var.naming_convention_info.name].names.0
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  tags                          = module.rt_name.naming_convention_output[var.naming_convention_info.name].tags.0
}