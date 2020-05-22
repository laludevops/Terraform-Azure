# Landing zone variables
locals {
  public_portal_subnet_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = []
  }

  network_watcher_storage_account_id = module.storage_account_network_watcher_logs.sst_output.id

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

# Vnet/Zone <public_portal> variables
locals {
  public_portal_naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.internet_zone_name
  }

  public_portal_tags = {}
}

#subnet/Tier <public_portal> parameters 
locals {

  public_portal_route_table_naming_convention_info = merge(local.public_portal_naming_convention_info, {
    tier = var.na_tier_name
    name = "0002"
  })
  public_portal_route_table_tags = merge(local.public_portal_tags, {
  })

  public_portal_web_tier_naming_convention_info = merge(local.public_portal_naming_convention_info, { tier = var.web_tier_name })
  public_portal_web_tier_tags = merge(local.public_portal_tags, {
  })

  public_portal_app_tier_naming_convention_info = merge(local.public_portal_naming_convention_info, { tier = var.app_tier_name })
  public_portal_app_tier_tags = merge(local.public_portal_tags, {
  })

  public_portal_db_tier_naming_convention_info = merge(local.public_portal_naming_convention_info, { tier = var.db_tier_name })
  public_portal_db_tier_tags = merge(local.public_portal_tags, {
  })

  public_portal_gut_tier_naming_convention_info = merge(local.public_portal_naming_convention_info, { tier = var.gut_tier_name })
  public_portal_gut_tier_tags = merge(local.public_portal_tags, {
  })

  public_portal_int_tier_naming_convention_info = merge(local.public_portal_naming_convention_info, { tier = var.integration_tier_name })
  public_portal_int_tier_tags = merge(local.public_portal_tags, {
  })

  public_portal_rsv_tier_naming_convention_info = merge(local.public_portal_naming_convention_info, { tier = var.app_tier_name })
  public_portal_rsv_tier_tags = merge(local.public_portal_tags, {
  })
}

module "dev_public_portal_spoke_route_table" {
  source                 = "../../../modules/az-terraform-route-table-routes"
  resource_group_name    = var.public_portal_route_table_resource_group_name
  location               = var.location
  routes                 = null
  naming_convention_info = local.public_portal_route_table_naming_convention_info
  tags                   = local.public_portal_route_table_tags
}

#region public_portal web tier
module "dev_public_portal_web_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_web_tier_naming_convention_info
  tags                    = local.public_portal_web_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.public_portal_web_0001_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_web_0001_tier_service_endpoints
      nsg_inbound       = var.public_portal_web_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_web_0001_tier_nsg_outbound_rules
      delegation        = var.public_portal_web_0001_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table]
}
#end-region public_portal web tier

#region public_portal app tier
module "dev_public_portal_app_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_app_tier_naming_convention_info
  tags                    = local.public_portal_app_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.public_portal_app_0001_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_app_0001_tier_service_endpoints
      nsg_inbound       = var.public_portal_app_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_app_0001_tier_nsg_outbound_rules
      delegation        = var.public_portal_app_0001_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_web_0001_tier]
}
#end-region public_portal app tier

#region public_portal cache tier
module "dev_public_portal_db_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_db_tier_naming_convention_info
  tags                    = local.public_portal_db_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.public_portal_db_0001_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_db_0001_tier_service_endpoints
      nsg_inbound       = var.public_portal_db_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_db_0001_tier_nsg_outbound_rules
      delegation        = var.public_portal_db_0001_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_app_0001_tier]
}
#end-region public_portal cache tier

#region public_portal gut tier
module "dev_public_portal_gut_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_gut_tier_naming_convention_info
  tags                    = local.public_portal_gut_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.public_portal_gut_0001_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_gut_0001_tier_service_endpoints
      nsg_inbound       = var.public_portal_gut_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_gut_0001_tier_nsg_outbound_rules
      delegation        = var.public_portal_gut_0001_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_db_0001_tier]
}
#end-region public_portal gut tier

#region public_portal int tier
module "dev_public_portal_int_0001_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_int_tier_naming_convention_info
  tags                    = local.public_portal_int_tier_tags
  subnets = {
    "0001" = {
      cidr              = var.public_portal_int_0001_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_int_0001_tier_service_endpoints
      nsg_inbound       = var.public_portal_int_0001_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_int_0001_tier_nsg_outbound_rules
      delegation        = var.public_portal_int_0001_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_gut_0001_tier]
}
#end-region public_portal int tier

#region public_portal rsv tier
module "dev_public_portal_app_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_rsv_tier_naming_convention_info
  tags                    = local.public_portal_rsv_tier_tags
  subnets = {
    "0002" = {
      cidr              = var.public_portal_app_0002_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_app_0002_tier_service_endpoints
      nsg_inbound       = var.public_portal_app_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_app_0002_tier_nsg_outbound_rules
      delegation        = var.public_portal_app_0002_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_int_0001_tier]
}
#end-region public_portal rsv tier

#region public_portal rsv tier
module "dev_public_portal_app_0003_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_rsv_tier_naming_convention_info
  tags                    = local.public_portal_rsv_tier_tags
  subnets = {
    "0003" = {
      cidr              = var.public_portal_app_0003_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_app_0003_tier_service_endpoints
      nsg_inbound       = var.public_portal_app_0003_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_app_0003_tier_nsg_outbound_rules
      delegation        = var.public_portal_app_0003_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_app_0002_tier]
}
#end-region public_portal rsv tier

#region public_portal db tier
module "dev_public_portal_db_0002_tier" {
  source                  = "../../../modules/az-terraform-network-subnet"
  resource_group_name     = var.public_portal_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.dev_level_1_resource_groups.rg_output.public.name
  virtual_network_name    = var.public_portal_spoke_vnet_name
  location                = var.location
  naming_convention_info  = local.public_portal_db_tier_naming_convention_info
  tags                    = local.public_portal_db_tier_tags
  subnets = {
    "0002" = {
      cidr              = var.public_portal_db_0002_tier_cidr
      route_table_id    = module.dev_public_portal_spoke_route_table.rt_output.id
      service_endpoints = var.public_portal_db_0002_tier_service_endpoints
      nsg_inbound       = var.public_portal_db_0002_tier_nsg_inbound_rules
      nsg_outbound      = var.public_portal_db_0002_tier_nsg_outbound_rules
      delegation        = var.public_portal_db_0002_tier_delegation
    }
  }
  diag_object  = local.public_portal_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.dev_public_portal_spoke_route_table, module.dev_public_portal_app_0003_tier]
}
#end-region public_portal db tier



