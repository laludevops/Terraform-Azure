# Landing spoke variables
locals {
  network_watcher_storage_account_id = module.storage_account_network_watcher_logs.sst_output.id

  common_subnet_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = []
  }

  networkwatcher_object = {
    network_watcher_name  = var.network_watcher_name
    resource_group_name   = var.netwatcher_resource_group_name
    storage_account_id    = local.network_watcher_storage_account_id
    retention_period_days = var.netwatcher_retention_days
    law = {
      id           = local.loga_id
      location     = var.location
      workspace_id = local.loga_workspace_id
    }
  }
}

# Vnet/spoke <Devops> variables
locals {
  devops_naming_convention_info = {
    project_code = var.project_code
    agency_code  = var.agency_code
    env          = var.env
    zone         = var.devops_zone_name
  }

  devops_tags = merge(local.landing_zone_tags, {})
}

#subnet/Tier <DevOps> parameters 
locals {
  devops_spoke_route_table_naming_convention_info = merge(local.devops_naming_convention_info, {
    tier = var.na_tier_name
    name = "0001"
  })
  devops_spoke_route_table_tags = merge(local.devops_tags, {})

  devops_tmt_tier_naming_convention_info = merge(local.devops_naming_convention_info, { tier = var.management_tier_name })
  devops_tmt_tier_tags                   = merge(local.devops_tags, {})

  devops_app_tier_naming_convention_info = merge(local.devops_naming_convention_info, { tier = var.app_tier_name })
  devops_app_tier_tags                   = merge(local.devops_tags, {})

  devops_db_tier_naming_convention_info = merge(local.devops_naming_convention_info, { tier = var.db_tier_name })
  devops_db_tier_tags                   = merge(local.devops_tags, {})

  # devops_rsv_tier_naming_convention_info  = merge(local.devops_naming_convention_info, { tier = var.rsv_tier_name })
  # devops_rsv_tier_tags = merge(local.devops_tags, {
  # })
}

module "devops_spoke_route_table" {
  source                 = "../../modules/az-terraform-route-table-routes"
  resource_group_name    = var.devops_spoke_route_table_resource_group_name
  location               = var.location
  routes                 = null
  naming_convention_info = local.devops_spoke_route_table_naming_convention_info
  tags                   = local.devops_spoke_route_table_tags
}

#region Devops aks tier
module "devops_aks_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.devops_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  virtual_network_name    = var.devops_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.devops_app_tier_naming_convention_info
  tags                    = local.devops_app_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.devops_aks_tier_cidr
      route_table_id    = module.devops_spoke_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.devops_aks_tier_service_endpoints
      nsg_inbound       = var.devops_aks_tier_nsg_inbound_rules
      nsg_outbound      = var.devops_aks_tier_nsg_outbound_rules
      delegation        = var.devops_aks_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.devops_spoke_route_table]
}
#end-region Devops aks tier


#region Devops tmt tier
module "devops_tmt_0001_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.devops_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  virtual_network_name    = var.devops_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.devops_tmt_tier_naming_convention_info
  tags                    = local.devops_tmt_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.devops_tmt_0001_tier_cidr
      route_table_id    = module.devops_spoke_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.devops_tmt_0001_tier_service_endpoints
      nsg_inbound       = var.devops_tmt_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.devops_tmt_0001_tier_nsg_outbound_rules
      delegation        = var.devops_tmt_0001_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.devops_spoke_route_table, module.devops_aks_tier]
}
#end-region Devops tmt tier

#region Devops tmt tier
module "devops_tmt_0002_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.devops_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  virtual_network_name    = var.devops_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.devops_tmt_tier_naming_convention_info
  tags                    = local.devops_tmt_tier_tags
  subnets = {
    "0002" = {
      cidr              = var.devops_tmt_0002_tier_cidr
      route_table_id    = module.devops_spoke_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.devops_tmt_0002_tier_service_endpoints
      nsg_inbound       = var.devops_tmt_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.devops_tmt_0002_tier_nsg_outbound_rules
      delegation        = var.devops_tmt_0002_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.devops_spoke_route_table, module.devops_tmt_0001_tier]
}
#end-region Devops tmt tier

#region Devops app tier
module "devops_app_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.devops_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  virtual_network_name    = var.devops_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.devops_app_tier_naming_convention_info
  tags                    = local.devops_app_tier_tags
  subnets = {
    "0002" = {
      cidr              = var.devops_app_tier_cidr
      route_table_id    = module.devops_spoke_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.devops_app_tier_service_endpoints
      nsg_inbound       = var.devops_app_tier_nsg_inbound_rules
      nsg_outbound      = var.devops_app_tier_nsg_outbound_rules
      delegation        = var.devops_app_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.devops_spoke_route_table, module.devops_tmt_0002_tier]
}
#end-region Devops app tier

#region Devops db tier
module "devops_db_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.devops_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  virtual_network_name    = var.devops_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.devops_db_tier_naming_convention_info
  tags                    = local.devops_db_tier_tags
  subnets = {
    "0002" = {
      cidr              = var.devops_db_tier_cidr
      route_table_id    = module.devops_spoke_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.devops_db_tier_service_endpoints
      nsg_inbound       = var.devops_db_tier_nsg_inbound_rules
      nsg_outbound      = var.devops_db_tier_nsg_outbound_rules
      delegation        = var.devops_db_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.devops_spoke_route_table, module.devops_app_tier]
}


#end-region Devops db tier
module "devops_aks_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.devops_aks_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "devops_tmt_0001_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.devops_tmt_0001_tier.snet_nsg_output, "0001", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "devops_tmt_0002_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.devops_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "devops_app_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.devops_app_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

module "devops_db_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.devops_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.devops_db_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

