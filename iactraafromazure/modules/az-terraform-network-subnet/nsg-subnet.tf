resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association" {
  for_each                  = module.nsg.nsg_output
  subnet_id                 = azurerm_subnet.subnet_obj[each.key].id
  network_security_group_id = each.value.id
  depends_on                = [azurerm_subnet.subnet_obj, module.nsg, azurerm_subnet_network_security_group_association.nsg_vnet_association]
}
