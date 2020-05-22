
output "snet_output" {
  depends_on = [azurerm_subnet.subnet_obj ]
  value = azurerm_subnet.subnet_obj
}


output "snet_nsg_output" {
  depends_on = [azurerm_subnet.subnet_obj ]
  value = {
    for key, value in azurerm_subnet.subnet_obj : 
            "${key}" => {
              subnet_info = value
              nsg_info    = lookup(module.nsg.nsg_output, key, {})
    }
  }
}

