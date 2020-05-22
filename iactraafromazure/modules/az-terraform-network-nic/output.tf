output "nic_output" {
    value = azurerm_network_interface.nic_obj
    # value = [ for k,v in azurerm_network_interface.nic_obj : v ]
}
