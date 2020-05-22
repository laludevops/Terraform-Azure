
output "devops_spoke_route_table_info" {
  value = {
    id                  = module.devops_spoke_route_table.rt_output.id
    name                = module.devops_spoke_route_table.rt_output.name
    resource_group_name = module.devops_spoke_route_table.rt_output.resource_group_name
  }
}

output "devops_aks_tier_info" {
  value = {
    id                   = lookup(lookup(module.devops_aks_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.devops_aks_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.devops_aks_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.devops_aks_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.devops_aks_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.devops_aks_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.devops_aks_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "devops_tmt_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.devops_tmt_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.devops_tmt_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.devops_tmt_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.devops_tmt_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.devops_tmt_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.devops_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.devops_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "devops_tmt_0002_tier_info" {
  value = {
    id                   = lookup(lookup(module.devops_tmt_0002_tier.snet_output, "0002", {}), "id", "")
    name                 = lookup(lookup(module.devops_tmt_0002_tier.snet_output, "0002", {}), "name", "")
    virtual_network_name = lookup(lookup(module.devops_tmt_0002_tier.snet_output, "0002", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.devops_tmt_0002_tier.snet_output, "0002", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.devops_tmt_0002_tier.snet_output, "0002", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.devops_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.devops_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  }
}


output "devops_app_tier_info" {
  value = {
    id                   = lookup(lookup(module.devops_app_tier.snet_output, "0002", {}), "id", "")
    name                 = lookup(lookup(module.devops_app_tier.snet_output, "0002", {}), "name", "")
    virtual_network_name = lookup(lookup(module.devops_app_tier.snet_output, "0002", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.devops_app_tier.snet_output, "0002", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.devops_app_tier.snet_output, "0002", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.devops_app_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.devops_app_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  }
}


output "devops_db_tier_info" {
  value = {
    id                   = lookup(lookup(module.devops_db_tier.snet_output, "0002", {}), "id", "")
    name                 = lookup(lookup(module.devops_db_tier.snet_output, "0002", {}), "name", "")
    virtual_network_name = lookup(lookup(module.devops_db_tier.snet_output, "0002", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.devops_db_tier.snet_output, "0002", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.devops_db_tier.snet_output, "0002", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.devops_db_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.devops_db_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  }
}

