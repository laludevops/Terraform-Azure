resource "azurerm_application_security_group" "asg_obj" {
  # count               = var.enabled ? 1 : 0
  name                = module.asg_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.asg_name.naming_convention_output[var.naming_convention_info.name].tags.0
}

