
resource "azurerm_network_interface" "nic_obj" {
  count                     = var.instance_count
  name                      = element(module.nic_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
  location                  = var.location
  resource_group_name       = var.resource_group_name
  network_security_group_id = var.nsg_id
  dns_servers               = var.dns_servers

  dynamic "ip_configuration" {
    for_each = var.nic_info
    content {
      name                          = element(module.ipconfig_name.naming_convention_output[ip_configuration.key].names, count.index)
      subnet_id                     = var.subnet_id
      primary                       = ip_configuration.value.is_primary
      private_ip_address_allocation = ip_configuration.value.private_ip_address == null ? "Dynamic" : "Static"
      public_ip_address_id          = null
      private_ip_address            = ip_configuration.value.private_ip_address == null ? null : ip_configuration.value.private_ip_address[count.index]
    }
  }
  depends_on = [var.dependencies]
  tags = element(module.nic_name.naming_convention_output[var.naming_convention_info.name].tags, count.index)
}
