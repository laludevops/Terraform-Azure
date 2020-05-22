#NSG name
locals {
  inbound_rules  = var.inbound_rules == null ? [] : var.inbound_rules
  outbound_rules = var.outbound_rules == null ? [] : var.outbound_rules
}
resource "azurerm_network_security_rule" "nsg_inbound_rule_obj" {
  for_each                    = { for key, value in local.inbound_rules : "${key}" => value }
  name                        = local.inbound_names[each.key].name
  depends_on                  = [var.dependencies]
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name

  priority                                   = each.value.priority
  direction                                  = "Inbound"
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_range                          = each.value.source_port_range
  destination_port_range                     = each.value.destination_port_range
  source_address_prefix                      = each.value.source_address_prefix
  destination_address_prefix                 = each.value.destination_address_prefix
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
}

resource "azurerm_network_security_rule" "nsg_outbound_rule_obj" {
  for_each                    = { for key, value in local.outbound_rules : "${key}" => value }
  name                        = local.outbound_names[each.key].name
  depends_on                  = [var.dependencies]
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name

  priority                                   = each.value.priority
  direction                                  = "Outbound"
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_range                          = each.value.source_port_range
  destination_port_range                     = each.value.destination_port_range
  source_address_prefix                      = each.value.source_address_prefix
  destination_address_prefix                 = each.value.destination_address_prefix
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
}

