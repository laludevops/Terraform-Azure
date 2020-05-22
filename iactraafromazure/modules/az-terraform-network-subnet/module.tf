resource "azurerm_subnet" "subnet_obj" {
  for_each              = var.subnets

  name                    = module.subnet_name.naming_convention_output[each.key].names.0
  resource_group_name     = var.resource_group_name
  virtual_network_name    = var.virtual_network_name
  address_prefix          = each.value.cidr
  service_endpoints       = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", null )
  enforce_private_link_service_network_policies = lookup(each.value, "enforce_private_link_service_network_policies", null)
  depends_on          = [var.dependencies]

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [1] : []
    
    content {
     name = lookup(each.value.delegation, "name", null)

     service_delegation {
       name = lookup(each.value.delegation.service_delegation, "name", null)
       actions = lookup(each.value.delegation.service_delegation, "actions", null)
     }
    }
  }
}