resource "azurerm_private_dns_zone" "private_dns_obj" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = merge(module.private_dns_name.naming_convention_output[var.naming_convention_info.name].tags.0, { Name = var.dns_zone_name })
}
