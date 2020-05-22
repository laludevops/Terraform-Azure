#subnet/Tier <management> parameters 
locals {
  management_zone_naming_convention_info = {
    project_code = var.project_code
    agency_code  = var.agency_code
    env          = var.env
    zone         = var.management_zone_name
  }

  management_tags = merge(local.landing_zone_tags, {})

  management_zone_route_table_naming_convention_info = merge(local.management_zone_naming_convention_info, {
    tier = var.na_tier_name
    name = "0001"
  })
  management_zone_route_table_tags = merge(local.management_tags, {
  })

  management_tmt_tier_naming_convention_info = merge(local.management_zone_naming_convention_info, { tier = var.management_tier_name })
  management_tmt_tier_tags = merge(local.management_tags, {
  })

  management_db_tier_naming_convention_info = merge(local.management_zone_naming_convention_info, { tier = var.db_tier_name })
  management_db_tier_tags = merge(local.management_tags, {
  })

  management_hsm_tier_naming_convention_info = merge(local.management_zone_naming_convention_info, { tier = var.hsm_tier_name })
  management_hsm_tier_tags = merge(local.management_tags, {
  })

}

module "management_zone_route_table" {
  source                 = "../../modules/az-terraform-route-table-routes"
  resource_group_name    = var.management_spoke_route_table_resource_group_name
  location               = var.location
  routes                 = null
  naming_convention_info = local.management_zone_route_table_naming_convention_info
  tags                   = local.management_zone_route_table_tags
}

#region management tmt tier
module "management_tmt_0001_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  virtual_network_name    = var.management_spoke_vnet_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  location                = var.location
  naming_convention_info  = local.management_tmt_tier_naming_convention_info
  tags                    = local.management_tmt_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.management_tmt_0001_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      service_endpoints = var.management_tmt_0001_tier_service_endpoints
      create_nsg        = true
      nsg_inbound       = var.management_tmt_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.management_tmt_0001_tier_nsg_outbound_rules
      delegation        = var.management_tmt_0001_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table]
}
#end-region management tmt tier

#region management db tier
module "management_db_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  virtual_network_name    = var.management_spoke_vnet_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  location                = var.location
  naming_convention_info  = local.management_db_tier_naming_convention_info
  tags                    = local.management_db_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.management_db_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      service_endpoints = var.management_db_tier_service_endpoints
      create_nsg        = true
      nsg_inbound       = var.management_db_tier_nsg_inbound_rules
      nsg_outbound      = var.management_db_tier_nsg_outbound_rules
      delegation        = var.management_db_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_tmt_0001_tier]
}
#end-region management db tier


# region management rsv 1 tier
module "management_tmt_0004_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  virtual_network_name    = var.management_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.management_tmt_tier_naming_convention_info
  tags                    = local.management_tmt_tier_tags
  subnets = {
    # "0001" = {
    "0004" = {
      cidr              = var.management_tmt_0004_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.management_tmt_0004_tier_service_endpoints
      nsg_inbound       = var.management_tmt_0004_tier_nsg_inbound_rules
      nsg_outbound      = var.management_tmt_0004_tier_nsg_outbound_rules
      delegation        = var.management_tmt_0004_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_db_tier]
}
# end-region management rsv tier


#region management tmt tier
module "management_tmt_0002_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  virtual_network_name    = var.management_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.management_tmt_tier_naming_convention_info
  tags                    = local.management_tmt_tier_tags
  subnets = {
    "0002" = {
      cidr              = var.management_tmt_0002_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      service_endpoints = var.management_tmt_0002_tier_service_endpoints
      create_nsg        = true
      nsg_inbound       = var.management_tmt_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.management_tmt_0002_tier_nsg_outbound_rules
      delegation        = var.management_tmt_0002_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_tmt_0004_tier]
}
#end-region management tmt tier


#region management tmt tier
module "management_tmt_0003_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  virtual_network_name    = var.management_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.management_tmt_tier_naming_convention_info
  tags                    = local.management_tmt_tier_tags
  subnets = {
    "0003" = {
      cidr              = var.management_tmt_0003_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      service_endpoints = var.management_tmt_0003_tier_service_endpoints
      create_nsg        = true
      nsg_inbound       = var.management_tmt_0003_tier_nsg_inbound_rules
      nsg_outbound      = var.management_tmt_0003_tier_nsg_outbound_rules
      delegation        = var.management_tmt_0003_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_tmt_0002_tier]
}
#end-region management tmt tier

#region management rsv2 tier
module "management_tmt_0005_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  virtual_network_name    = var.management_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.management_tmt_tier_naming_convention_info
  tags                    = local.management_tmt_tier_tags
  subnets = {
    # "0002" = {
    "0005" = {
      cidr              = var.management_tmt_0005_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.management_tmt_0005_tier_service_endpoints
      nsg_inbound       = var.management_tmt_0005_tier_nsg_inbound_rules
      nsg_outbound      = var.management_tmt_0005_tier_nsg_outbound_rules
      delegation        = var.management_tmt_0005_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_tmt_0003_tier]
}
#end-region management rsv2 tier

#region management rsv3 tier
module "management_tmt_0006_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  virtual_network_name    = var.management_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.management_tmt_tier_naming_convention_info
  tags                    = local.management_tmt_tier_tags
  subnets = {
    # "0003" = {
    "0006" = {
      cidr              = var.management_tmt_0006_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.management_tmt_0006_tier_service_endpoints
      nsg_inbound       = var.management_tmt_0006_tier_nsg_inbound_rules
      nsg_outbound      = var.management_tmt_0006_tier_nsg_outbound_rules
      delegation        = var.management_tmt_0006_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_tmt_0005_tier]
}
#end-region management rsv3 tier

#region management HSM tier
module "management_hsm_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.management_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  virtual_network_name    = var.management_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.management_hsm_tier_naming_convention_info
  tags                    = local.management_hsm_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.management_hsm_tier_cidr
      route_table_id    = module.management_zone_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.management_hsm_tier_service_endpoints
      nsg_inbound       = var.management_hsm_tier_nsg_inbound_rules
      nsg_outbound      = var.management_hsm_tier_nsg_outbound_rules
      delegation        = var.management_hsm_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.management_zone_route_table, module.management_tmt_0006_tier]
}
#end-region management HSM tier

#nsg rules

module "management_tmt_0001_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_db_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_db_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_tmt_0004_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_tmt_0004_tier.snet_nsg_output, "0004", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_tmt_0002_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_tmt_0003_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_tmt_0003_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_tmt_0005_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_tmt_0005_tier.snet_nsg_output, "0005", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_tmt_0006_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_tmt_0006_tier.snet_nsg_output, "0006", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "management_hsm_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.management_hsm_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

