
output "management_zone_route_table_info" {
  value = {
    id                  = module.management_zone_route_table.rt_output.id
    name                = module.management_zone_route_table.rt_output.name
    resource_group_name = module.management_zone_route_table.rt_output.resource_group_name
  }
}

output "management_tmt_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_tmt_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.management_tmt_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_tmt_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_tmt_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_tmt_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "management_tmt_0002_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_tmt_0002_tier.snet_output, "0002", {}), "id", "")
    name                 = lookup(lookup(module.management_tmt_0002_tier.snet_output, "0002", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_tmt_0002_tier.snet_output, "0002", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_tmt_0002_tier.snet_output, "0002", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_tmt_0002_tier.snet_output, "0002", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  }
}

output "management_tmt_0003_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_tmt_0003_tier.snet_output, "0003", {}), "id", "")
    name                 = lookup(lookup(module.management_tmt_0003_tier.snet_output, "0003", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_tmt_0003_tier.snet_output, "0003", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_tmt_0003_tier.snet_output, "0003", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_tmt_0003_tier.snet_output, "0003", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_tmt_0003_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_tmt_0003_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "name", "")
  }
}


output "management_db_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_db_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.management_db_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_db_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_db_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_db_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_db_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_db_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "management_tmt_0004_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_tmt_0004_tier.snet_output, "0004", {}), "id", "")
    name                 = lookup(lookup(module.management_tmt_0004_tier.snet_output, "0004", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_tmt_0004_tier.snet_output, "0004", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_tmt_0004_tier.snet_output, "0004", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_tmt_0004_tier.snet_output, "0004", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_tmt_0004_tier.snet_nsg_output, "0004", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_tmt_0004_tier.snet_nsg_output, "0004", {}), "nsg_info", {}), "name", "")
  }
}

output "management_tmt_0005_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_tmt_0005_tier.snet_output, "0005", {}), "id", "")
    name                 = lookup(lookup(module.management_tmt_0005_tier.snet_output, "0005", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_tmt_0005_tier.snet_output, "0005", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_tmt_0005_tier.snet_output, "0005", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_tmt_0005_tier.snet_output, "0005", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_tmt_0005_tier.snet_nsg_output, "0005", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_tmt_0005_tier.snet_nsg_output, "0005", {}), "nsg_info", {}), "name", "")
  }
}

output "management_tmt_0006_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_tmt_0006_tier.snet_output, "0006", {}), "id", "")
    name                 = lookup(lookup(module.management_tmt_0006_tier.snet_output, "0006", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_tmt_0006_tier.snet_output, "0006", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_tmt_0006_tier.snet_output, "0006", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_tmt_0006_tier.snet_output, "0006", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_tmt_0006_tier.snet_nsg_output, "0006", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_tmt_0006_tier.snet_nsg_output, "0006", {}), "nsg_info", {}), "name", "")
  }
}

output "management_hsm_tier_info" {
  value = {
    id                   = lookup(lookup(module.management_hsm_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.management_hsm_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.management_hsm_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.management_hsm_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.management_hsm_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.management_hsm_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.management_hsm_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}
