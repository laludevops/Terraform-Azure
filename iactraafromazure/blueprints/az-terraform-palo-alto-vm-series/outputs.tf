output "FW_MGMT_URL" {
  value = join("", ["https://", azurerm_public_ip.PublicIP_0.ip_address])
}

output "FW_UNTRUST_Public_IP" {
  value = azurerm_public_ip.PublicIP_1.ip_address
}

output "FW_eth0" {
  value = azurerm_network_interface.FW1-VNIC0.private_ip_address
}

output "FW_eth1" {
  value = azurerm_network_interface.FW1-VNIC1.private_ip_address
}

output "FW_eth2" {
  value = azurerm_network_interface.FW1-VNIC2.private_ip_address
}
