resource "azurerm_route" "route_obj" {
  for_each                = var.routes == null ? {} : var.routes
  name                    = module.rt_route_name.naming_convention_output[each.key].names.0
  resource_group_name     = var.resource_group_name
  route_table_name        = var.route_table_name
  address_prefix          = each.value.destination_CIDR
  #set the value to VirtualAppliance, when the next_hop_in_ip_address is set
  next_hop_type           = each.value.next_hop_in_ip_address != null ? "VirtualAppliance" : each.value.next_hop_type
  #set the value to null, if the passed value != VirtualAppliance since this field is supported for only VirtualAppliance
  next_hop_in_ip_address  = each.value.next_hop_type != "VirtualAppliance" ? null : each.value.next_hop_in_ip_address
}