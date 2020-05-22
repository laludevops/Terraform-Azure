module "routes" {
  source = "../az-terraform-routes"
  resource_group_name         = var.resource_group_name
  route_table_name            = azurerm_route_table.rt_obj.name
  routes                      = var.routes
  naming_convention_info      = var.naming_convention_info
  tags                        = var.tags
}