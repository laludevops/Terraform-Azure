# Landing zone variables
locals {
  transit_hub_subnet_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = []
  }
}

# Vnet/Zone <transit_hub> variables
locals {
  transit_hub_naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.intranet_zone_name
  }

  transit_hub_tags = merge(local.landing_zone_tags, {})
}


module "ort_transit_hub_spoke_route_table" {
  source              = "../../../modules/az-terraform-route-table-routes"
  resource_group_name = var.transit_hub_route_table_resource_group_name
  location            = var.location
  routes              = null
  naming_convention_info = merge(local.transit_hub_naming_convention_info, {
    tier = var.na_tier_name
    name = "0002"
  })
  tags = merge(local.transit_hub_tags, {
  })
}

#region transit_hub app tier
module "ort_transit_hub_app_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.app_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.transit_hub_app_0001_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_app_0001_tier_service_endpoints
      nsg_inbound       = var.transit_hub_app_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_app_0001_tier_nsg_outbound_rules
      delegation        = var.transit_hub_app_0001_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub app tier

#region transit_hub tmt tier
module "ort_transit_hub_tmt_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.management_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.transit_hub_tmt_0001_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_tmt_0001_tier_service_endpoints
      nsg_inbound       = var.transit_hub_tmt_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_tmt_0001_tier_nsg_outbound_rules
      delegation        = var.transit_hub_tmt_0001_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub tmt tier

#region transit_hub rsv tier
module "ort_transit_hub_app_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.app_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0002" = {
      cidr              = var.transit_hub_app_0002_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_app_0002_tier_service_endpoints
      nsg_inbound       = var.transit_hub_app_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_app_0002_tier_nsg_outbound_rules
      delegation        = var.transit_hub_app_0002_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub rsv tier


#region transit_hub rsv tier
module "ort_transit_hub_tmt_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.management_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0002" = {
      cidr              = var.transit_hub_tmt_0002_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_tmt_0002_tier_service_endpoints
      nsg_inbound       = var.transit_hub_tmt_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_tmt_0002_tier_nsg_outbound_rules
      delegation        = var.transit_hub_tmt_0002_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub rsv tier


#region transit_hub rsv tier
module "ort_transit_hub_tmt_0003_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.management_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0003" = {
      cidr              = var.transit_hub_tmt_0003_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_tmt_0003_tier_service_endpoints
      nsg_inbound       = var.transit_hub_tmt_0003_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_tmt_0003_tier_nsg_outbound_rules
      delegation        = var.transit_hub_tmt_0003_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub rsv tier


#region transit_hub Ingress tier (Untrust)
module "ort_transit_hub_ingress_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.ingress_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.transit_hub_ingress_0001_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_ingress_0001_tier_service_endpoints
      nsg_inbound       = var.transit_hub_ingress_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_ingress_0001_tier_nsg_outbound_rules
      delegation        = var.transit_hub_ingress_0001_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub Ingress tier

#region transit_hub Egress tier (trust)
module "ort_transit_hub_egress_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.transit_hub_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  virtual_network_name    = var.transit_hub_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.transit_hub_naming_convention_info, { tier = var.egress_tier_name })
  tags                    = merge(local.transit_hub_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.transit_hub_egress_0001_tier_cidr
      route_table_id    = module.ort_transit_hub_spoke_route_table.rt_output.id
      service_endpoints = var.transit_hub_egress_0001_tier_service_endpoints
      nsg_inbound       = var.transit_hub_egress_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.transit_hub_egress_0001_tier_nsg_outbound_rules
      delegation        = var.transit_hub_egress_0001_tier_delegation
    }
  }
  diag_object  = local.transit_hub_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_transit_hub_spoke_route_table]
}
#end-region transit_hub Egress tier


# nsg rules default
module "ort_transit_hub_app_0001_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_app_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_transit_hub_tmt_0001_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_transit_hub_app_0002_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_app_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_transit_hub_tmt_0002_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_transit_hub_tmt_0003_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_tmt_0003_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_transit_hub_ingress_0001_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_ingress_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "ort_transit_hub_egress_0001_tier_nsg_rule_deny_all" {
  source              = "../../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.transit_hub.name
  nsg_name            = lookup(lookup(lookup(module.ort_transit_hub_egress_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}
