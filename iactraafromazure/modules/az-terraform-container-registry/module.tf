resource "azurerm_container_registry" "acr_obj" {
  name                = module.acr_name.naming_convention_output["${var.naming_convention_info.name}"].names.0
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_enabled       = false
  sku                 = var.sku
  tags                = module.acr_name.naming_convention_output["${var.naming_convention_info.name}"].tags.0

  # network_rule_set {
  #   default_action    = "Deny"
  #   dynamic "virtual_network" {
  #     iterator      = nwrules
  #     for_each      = var.vnet_rule
  #     content {
  #       action      = "Allow"
  #       subnet_id   = nwrules.value[1]
  #     }
  #   }
  # }
}
