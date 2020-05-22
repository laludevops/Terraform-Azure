# Landing zone variables
locals {
  intranet_ingress_egress_subnet_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = []
  }
}

# Vnet/Zone <intranet_ingress_egress> variables
locals {
  intranet_ingress_egress_naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.intranet_zone_name
  }

  intranet_ingress_egress_tags = merge(local.landing_zone_tags, {})
}

#subnet/Tier <intranet_ingress_egress> parameters 
locals {

  intranet_ingress_egress_route_table_naming_convention_info = merge(local.intranet_ingress_egress_naming_convention_info, {
    tier = var.na_tier_name
    name = "0001"
  })
  intranet_ingress_egress_route_table_tags = merge(local.intranet_ingress_egress_tags, {
  })

  intranet_ingress_egress_gut_tier_naming_convention_info = merge(local.intranet_ingress_egress_naming_convention_info, { tier = var.gut_tier_name })
  intranet_ingress_egress_gut_tier_tags = merge(local.intranet_ingress_egress_tags, {
  })

  intranet_ingress_egress_rsv_tier_naming_convention_info = merge(local.intranet_ingress_egress_naming_convention_info, { tier = var.management_tier_name })
  intranet_ingress_egress_rsv_tier_tags = merge(local.intranet_ingress_egress_tags, {
  })
}

module "ort_intranet_ingress_egress_spoke_route_table" {
  source                 = "../../../modules/az-terraform-route-table-routes"
  resource_group_name    = var.intranet_ingress_egress_route_table_resource_group_name
  location               = var.location
  routes                 = null
  naming_convention_info = local.intranet_ingress_egress_route_table_naming_convention_info
  tags                   = local.intranet_ingress_egress_route_table_tags
}

#region intranet_ingress_egress rsv tier
module "ort_intranet_ingress_egress_tmt_0005_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.intranet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  virtual_network_name    = var.intranet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.intranet_ingress_egress_rsv_tier_naming_convention_info
  tags                    = local.intranet_ingress_egress_rsv_tier_tags
  subnets = {
    "0005" = {
      cidr              = var.intranet_ingress_egress_tmt_0005_tier_cidr
      route_table_id    = module.ort_intranet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.intranet_ingress_egress_tmt_0005_tier_service_endpoints
      nsg_inbound       = var.intranet_ingress_egress_tmt_0005_tier_nsg_inbound_rules
      nsg_outbound      = var.intranet_ingress_egress_tmt_0005_tier_nsg_outbound_rules
      delegation        = var.intranet_ingress_egress_tmt_0005_tier_delegation
    }
  }
  diag_object  = local.intranet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_intranet_ingress_egress_spoke_route_table]
}
#end-region intranet_ingress_egress rsv tier

#region intranet_ingress_egress rsv tier (managment)
module "ort_intranet_ingress_egress_tmt_0006_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.intranet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  virtual_network_name    = var.intranet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.intranet_ingress_egress_naming_convention_info, { tier = var.egress_tier_name })
  tags                    = merge(local.intranet_ingress_egress_tags, {})
  subnets = {
    "0006" = {
      cidr              = var.intranet_ingress_egress_tmt_0006_tier_cidr
      route_table_id    = module.ort_intranet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.intranet_ingress_egress_tmt_0006_tier_service_endpoints
      nsg_inbound       = var.intranet_ingress_egress_tmt_0006_tier_nsg_inbound_rules
      nsg_outbound      = var.intranet_ingress_egress_tmt_0006_tier_nsg_outbound_rules
      delegation        = var.intranet_ingress_egress_tmt_0006_tier_delegation
    }
  }
  diag_object  = local.intranet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_intranet_ingress_egress_spoke_route_table, module.ort_intranet_ingress_egress_tmt_0005_tier]
}
#end-region intranet_ingress_egress rsv tier


#region intranet_ingress_egress gut tier
module "ort_intranet_ingress_egress_gut_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.intranet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  virtual_network_name    = var.intranet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.intranet_ingress_egress_naming_convention_info, { tier = var.gut_tier_name })
  tags                    = merge(local.intranet_ingress_egress_tags, {})
  subnets = {
    "0002" = {
      cidr              = var.intranet_ingress_egress_gut_0002_tier_cidr
      route_table_id    = module.ort_intranet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.intranet_ingress_egress_gut_0002_tier_service_endpoints
      nsg_inbound       = var.intranet_ingress_egress_gut_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.intranet_ingress_egress_gut_0002_tier_nsg_outbound_rules
      delegation        = var.intranet_ingress_egress_gut_0002_tier_delegation
    }
  }
  diag_object  = local.intranet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_intranet_ingress_egress_spoke_route_table, module.ort_intranet_ingress_egress_tmt_0006_tier]
}
#end-region intranet_ingress_egress gut tier


#region intranet_ingress_egress Ingress tier (Untrust)
module "ort_intranet_ingress_egress_ingress_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.intranet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  virtual_network_name    = var.intranet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.intranet_ingress_egress_naming_convention_info, { tier = var.ingress_tier_name })
  tags                    = merge(local.intranet_ingress_egress_tags, {})
  subnets = {
    "0002" = {
      cidr              = var.intranet_ingress_egress_ingress_0002_tier_cidr
      route_table_id    = module.ort_intranet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.intranet_ingress_egress_ingress_0002_tier_service_endpoints
      nsg_inbound       = var.intranet_ingress_egress_ingress_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.intranet_ingress_egress_ingress_0002_tier_nsg_outbound_rules
      delegation        = var.intranet_ingress_egress_ingress_0002_tier_delegation
    }
  }
  diag_object  = local.intranet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_intranet_ingress_egress_spoke_route_table, module.ort_intranet_ingress_egress_gut_0002_tier]
}
#end-region intranet_ingress_egress Ingress tier

#region intranet_ingress_egress Egress tier (trust)
module "ort_intranet_ingress_egress_egress_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.intranet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  virtual_network_name    = var.intranet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.intranet_ingress_egress_naming_convention_info, { tier = var.egress_tier_name })
  tags                    = merge(local.intranet_ingress_egress_tags, {})
  subnets = {
    "0002" = {
      cidr              = var.intranet_ingress_egress_egress_0002_tier_cidr
      route_table_id    = module.ort_intranet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.intranet_ingress_egress_egress_0002_tier_service_endpoints
      nsg_inbound       = var.intranet_ingress_egress_egress_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.intranet_ingress_egress_egress_0002_tier_nsg_outbound_rules
      delegation        = var.intranet_ingress_egress_egress_0002_tier_delegation
    }
  }
  diag_object  = local.intranet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_intranet_ingress_egress_spoke_route_table, module.ort_intranet_ingress_egress_ingress_0002_tier]
}
#end-region intranet_ingress_egress Egress tier



#region intranet_ingress_egress tmt tier
module "ort_intranet_ingress_egress_tmt_0004_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.intranet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  virtual_network_name    = var.intranet_ingress_egress_spoke_vnet_name
  location                = var.location
  tags                    = local.intranet_ingress_egress_rsv_tier_tags
  naming_convention_info  = local.intranet_ingress_egress_rsv_tier_naming_convention_info
  subnets = {
    "0004" = {
      cidr              = var.intranet_ingress_egress_tmt_0004_tier_cidr
      route_table_id    = module.ort_intranet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.intranet_ingress_egress_tmt_0004_tier_service_endpoints
      nsg_inbound       = var.intranet_ingress_egress_tmt_0004_tier_nsg_inbound_rules
      nsg_outbound      = var.intranet_ingress_egress_tmt_0004_tier_nsg_outbound_rules
      delegation        = var.intranet_ingress_egress_tmt_0004_tier_delegation
    }
  }
  diag_object  = local.intranet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_intranet_ingress_egress_spoke_route_table, module.ort_intranet_ingress_egress_egress_0002_tier]
}
#end-region intranet_ingress_egress tmt tier


#nsg default rules
module "ort_intranet_ingress_egress_tmt_0005_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  nsg_name            = lookup(lookup(lookup(module.ort_intranet_ingress_egress_tmt_0005_tier.snet_nsg_output, "0005", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_intranet_ingress_egress_tmt_0006_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  nsg_name            = lookup(lookup(lookup(module.ort_intranet_ingress_egress_tmt_0006_tier.snet_nsg_output, "0006", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_intranet_ingress_egress_gut_0002_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  nsg_name            = lookup(lookup(lookup(module.ort_intranet_ingress_egress_gut_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}


module "ort_intranet_ingress_egress_ingress_0002_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  nsg_name            = lookup(lookup(lookup(module.ort_intranet_ingress_egress_ingress_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_intranet_ingress_egress_egress_0002_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  nsg_name            = lookup(lookup(lookup(module.ort_intranet_ingress_egress_egress_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_intranet_ingress_egress_tmt_0004_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.iz_ingress_egress.name
  nsg_name            = lookup(lookup(lookup(module.ort_intranet_ingress_egress_tmt_0004_tier.snet_nsg_output, "0004", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}



