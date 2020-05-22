output "dev_public_portal_spoke_route_table_info" {
  value = {
    id                  = module.dev_public_portal_spoke_route_table.rt_output.id
    name                = module.dev_public_portal_spoke_route_table.rt_output.name
    resource_group_name = module.dev_public_portal_spoke_route_table.rt_output.resource_group_name
  }
}


output "dev_public_portal_web_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_web_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_web_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_web_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_web_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_web_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_web_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_web_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "dev_public_portal_app_0003_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_app_0003_tier.snet_output, "0003", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_app_0003_tier.snet_output, "0003", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_app_0003_tier.snet_output, "0003", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_app_0003_tier.snet_output, "0003", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_app_0003_tier.snet_output, "0003", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_app_0003_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_app_0003_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "name", "")
  }
}


output "dev_public_portal_app_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_app_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_app_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_app_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_app_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_app_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_app_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_app_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "dev_public_portal_db_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_db_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_db_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_db_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_db_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_db_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_db_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_db_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "dev_public_portal_gut_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_gut_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "dev_public_portal_int_0001_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_int_0001_tier.snet_output, "0001", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_int_0001_tier.snet_output, "0001", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_int_0001_tier.snet_output, "0001", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_int_0001_tier.snet_output, "0001", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_int_0001_tier.snet_output, "0001", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_int_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_int_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  }
}

output "dev_public_portal_app_0002_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_app_0002_tier.snet_output, "0002", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_app_0002_tier.snet_output, "0002", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_app_0002_tier.snet_output, "0002", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_app_0002_tier.snet_output, "0002", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_app_0002_tier.snet_output, "0002", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_app_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_app_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  }
}

output "dev_public_portal_db_0002_tier_info" {
  value = {
    id                   = lookup(lookup(module.dev_public_portal_db_0002_tier.snet_output, "0002", {}), "id", "")
    name                 = lookup(lookup(module.dev_public_portal_db_0002_tier.snet_output, "0002", {}), "name", "")
    virtual_network_name = lookup(lookup(module.dev_public_portal_db_0002_tier.snet_output, "0002", {}), "virtual_network_name", "")
    resource_group_name  = lookup(lookup(module.dev_public_portal_db_0002_tier.snet_output, "0002", {}), "resource_group_name", "")
    address_prefix       = lookup(lookup(module.dev_public_portal_db_0002_tier.snet_output, "0002", {}), "address_prefix", "")
    nsg_id               = lookup(lookup(lookup(module.dev_public_portal_db_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nsg_name             = lookup(lookup(lookup(module.dev_public_portal_db_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  }
}
