# resource "azurerm_network_interface_application_security_group_association" "asg_nic_obj" {
#   count                         = var.asg_id != null && var.asg_id != "" && length(azurerm_network_interface.nic_obj) > 0 ? var.instance_count : 0
#   network_interface_id          = azurerm_network_interface.nic_obj[count.index].id
#   application_security_group_id = var.asg_id
#   //remove it in 2.0 
#   ip_configuration_name         = azurerm_network_interface.nic_obj[count.index].ip_configuration[0].name
#   depends_on                    = [azurerm_network_interface.nic_obj]
# }
