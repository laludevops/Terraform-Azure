resource "azurerm_subnet_route_table_association" "subnet_routes" {
  for_each       = azurerm_subnet.subnet_obj
  subnet_id      = lookup(lookup(azurerm_subnet.subnet_obj, each.key, {}), "id", "")
  route_table_id = lookup(lookup(var.subnets, each.key, {}), "route_table_id", "")
  depends_on     = [azurerm_subnet.subnet_obj]
}
