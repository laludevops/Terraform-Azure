
output "developer_spoke_route_table_info" {
  value = {
    id                  = module.developer_spoke_route_table.rt_output.id
    name                = module.developer_spoke_route_table.rt_output.name
    resource_group_name = module.developer_spoke_route_table.rt_output.resource_group_name
  }
}

output "developer_dev_tier_info" {
  value = {
    id                   = lookup(lookup(module.developer_dev_tier.snet_output, "0003", {}), "id", "")
    name                 = lookup(lookup(module.developer_dev_tier.snet_output, "0003", {}), "name", "")
    virtual_network_name = lookup(lookup(module.developer_dev_tier.snet_output, "0003", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.developer_dev_tier.snet_output, "0003", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.developer_dev_tier.snet_output, "0003", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.developer_dev_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.developer_dev_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "name", "")
  }
}

