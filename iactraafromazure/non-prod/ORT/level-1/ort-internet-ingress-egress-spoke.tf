# Landing zone variables
locals {
  internet_ingress_egress_subnet_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = []
  }
}

# Vnet/Zone <internet_ingress_egress> variables
locals {
  internet_ingress_egress_naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.internet_zone_name
  }

  internet_ingress_egress_tags = merge(local.landing_zone_tags, {})
}

#subnet/Tier <internet_ingress_egress> parameters 
locals {
  internet_ingress_egress_rsv_tier_naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { tier = var.management_tier_name })
  internet_ingress_egress_rsv_tier_tags = merge(local.internet_ingress_egress_tags, {
  })
}

module "ort_internet_ingress_egress_spoke_route_table" {
  source              = "../../../modules/az-terraform-route-table-routes"
  resource_group_name = var.internet_ingress_egress_route_table_resource_group_name
  location            = var.location
  routes              = null
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, {
    tier = var.na_tier_name
    name = "0001"
  })
  tags = merge(local.internet_ingress_egress_tags, {})
}


#region internet_ingress_egress rsv tier
module "ort_internet_ingress_egress_tmt_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.internet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = lookup(lookup(module.ort_level_1_resource_groups.rg_output, "ez_ingress_egress"), "name")
  virtual_network_name    = var.internet_ingress_egress_spoke_vnet_name
  location                = var.location
  tags                    = local.internet_ingress_egress_rsv_tier_tags
  naming_convention_info  = local.internet_ingress_egress_rsv_tier_naming_convention_info
  subnets = {
    "0002" = {
      cidr              = var.internet_ingress_egress_tmt_0002_tier_cidr
      route_table_id    = module.ort_internet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.internet_ingress_egress_tmt_0002_tier_service_endpoints
      nsg_inbound       = var.internet_ingress_egress_tmt_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.internet_ingress_egress_tmt_0002_tier_nsg_outbound_rules
      delegation        = var.internet_ingress_egress_tmt_0002_tier_delegation
    }
  }
  diag_object  = local.internet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_internet_ingress_egress_spoke_route_table]
}
#end-region internet_ingress_egress rsv tier

#region internet_ingress_egress rsv tier
module "ort_internet_ingress_egress_tmt_0003_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.internet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = lookup(lookup(module.ort_level_1_resource_groups.rg_output, "ez_ingress_egress"), "name")
  virtual_network_name    = var.internet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.internet_ingress_egress_rsv_tier_naming_convention_info
  tags                    = local.internet_ingress_egress_rsv_tier_tags
  subnets = {
    "0003" = {
      cidr              = var.internet_ingress_egress_tmt_0003_tier_cidr
      route_table_id    = module.ort_internet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.internet_ingress_egress_tmt_0003_tier_service_endpoints
      nsg_inbound       = var.internet_ingress_egress_tmt_0003_tier_nsg_inbound_rules
      nsg_outbound      = var.internet_ingress_egress_tmt_0003_tier_nsg_outbound_rules
      delegation        = var.internet_ingress_egress_tmt_0003_tier_delegation
    }
  }
  diag_object  = local.internet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_internet_ingress_egress_spoke_route_table, module.ort_internet_ingress_egress_tmt_0002_tier]
}
#end-region internet_ingress_egress rsv tier

#region internet_ingress_egress gut tier
module "ort_internet_ingress_egress_gut_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.internet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = lookup(lookup(module.ort_level_1_resource_groups.rg_output, "ez_ingress_egress"), "name")
  virtual_network_name    = var.internet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.internet_ingress_egress_naming_convention_info, { tier = var.gut_tier_name })
  tags                    = merge(local.internet_ingress_egress_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.internet_ingress_egress_gut_0001_tier_cidr
      route_table_id    = module.ort_internet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.internet_ingress_egress_gut_0001_tier_service_endpoints
      nsg_inbound       = var.internet_ingress_egress_gut_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.internet_ingress_egress_gut_0001_tier_nsg_outbound_rules
      delegation        = var.internet_ingress_egress_gut_0001_tier_delegation
    }
  }
  diag_object  = local.internet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_internet_ingress_egress_spoke_route_table, module.ort_internet_ingress_egress_tmt_0003_tier]
}
#end-region internet_ingress_egress gut tier


#region internet_ingress_egress Ingress tier (Untrust)
module "ort_internet_ingress_egress_ingress_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.internet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = lookup(lookup(module.ort_level_1_resource_groups.rg_output, "ez_ingress_egress"), "name")
  virtual_network_name    = var.internet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.internet_ingress_egress_naming_convention_info, { tier = var.ingress_tier_name })
  tags                    = merge(local.internet_ingress_egress_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.internet_ingress_egress_ingress_0001_tier_cidr
      route_table_id    = module.ort_internet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.internet_ingress_egress_ingress_0001_tier_service_endpoints
      nsg_inbound       = var.internet_ingress_egress_ingress_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.internet_ingress_egress_ingress_0001_tier_nsg_outbound_rules
      delegation        = var.internet_ingress_egress_ingress_0001_tier_delegation
    }
  }
  diag_object  = local.internet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_internet_ingress_egress_spoke_route_table, module.ort_internet_ingress_egress_gut_0001_tier]
}
#end-region internet_ingress_egress Ingress tier

#region internet_ingress_egress Egress tier (trust)
module "ort_internet_ingress_egress_egress_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.internet_ingress_egress_spoke_vnet_resource_group_name
  nsg_resource_group_name = lookup(lookup(module.ort_level_1_resource_groups.rg_output, "ez_ingress_egress"), "name")
  virtual_network_name    = var.internet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.internet_ingress_egress_naming_convention_info, { tier = var.egress_tier_name })
  tags                    = merge(local.internet_ingress_egress_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.internet_ingress_egress_egress_0001_tier_cidr
      route_table_id    = module.ort_internet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.internet_ingress_egress_egress_0001_tier_service_endpoints
      nsg_inbound       = var.internet_ingress_egress_egress_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.internet_ingress_egress_egress_0001_tier_nsg_outbound_rules
      delegation        = var.internet_ingress_egress_egress_0001_tier_delegation
    }
  }
  diag_object  = local.internet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_internet_ingress_egress_spoke_route_table, module.ort_internet_ingress_egress_ingress_0001_tier]
}
#end-region internet_ingress_egress Egress tier

#region internet_ingress_egress tmt tier (managment) -- change here var.management_tier_name from var.egress_tier_name
module "ort_internet_ingress_egress_tmt_0001_tier" {
  source              = "../../../modules/az-terraform-network-subnet"
  resource_group_name = var.internet_ingress_egress_spoke_vnet_resource_group_name

  nsg_resource_group_name = lookup(lookup(module.ort_level_1_resource_groups.rg_output, "ez_ingress_egress"), "name")
  virtual_network_name    = var.internet_ingress_egress_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.internet_ingress_egress_naming_convention_info, { tier = var.management_tier_name })
  tags                    = merge(local.internet_ingress_egress_tags, {})
  subnets = {
    "0001" = {
      cidr              = var.internet_ingress_egress_tmt_0001_tier_cidr
      route_table_id    = module.ort_internet_ingress_egress_spoke_route_table.rt_output.id
      service_endpoints = var.internet_ingress_egress_tmt_0001_tier_service_endpoints
      nsg_inbound       = var.internet_ingress_egress_tmt_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.internet_ingress_egress_tmt_0001_tier_nsg_outbound_rules
      delegation        = var.internet_ingress_egress_tmt_0001_tier_delegation
    }
  }
  diag_object  = local.internet_ingress_egress_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.ort_internet_ingress_egress_spoke_route_table, module.ort_internet_ingress_egress_egress_0001_tier]
}
#end-region internet_ingress_egress tmt tier

