resource "azurerm_public_ip" "pip_object" {
  name                = module.pip_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  allocation_method   = lower(var.sku) == "standard" ? "Static" : var.allocation_method
  domain_name_label   = var.domain_name_label
  zones               = var.zones
  reverse_fqdn        = var.fqdn
  tags                = module.pip_name.naming_convention_output[var.naming_convention_info.name].tags.0
}
