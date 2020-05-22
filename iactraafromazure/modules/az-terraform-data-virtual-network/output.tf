output "virtual_network_id" {
  value = data.azurerm_virtual_network.data_vnet.id
}

output "virtual_network_address_space" {
  value = data.azurerm_virtual_network.data_vnet.address_space
}