
#Landing zone variables
locals {

  landing_zone_tags = {
    Landing-Zone = "level1"
    location     = var.location
  }
  # loga_id                           = module.common_log_analytics_workspace.loga_output.id
  # loga_workspace_id                 = module.common_log_analytics_workspace.loga_output.workspace_id
  loga_id           = data.azurerm_log_analytics_workspace.loga_obj.id
  loga_workspace_id = data.azurerm_log_analytics_workspace.loga_obj.workspace_id

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


#Vnet/Zone - common services variables 
locals {
  common_naming_convention_info = {
    project_code = var.project_code
    agency_code  = var.agency_code
    env          = var.env
    zone         = var.devops_zone_name
    tier         = var.na_tier_name
  }

  common_services_tags = merge(local.landing_zone_tags, {
  })

}

data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = var.loga_workspace_name
  resource_group_name = var.loga_resource_group_name
}

#storage account for network watcher flow logs
module "storage_account_network_watcher_logs" {
  source              = "../../../../modules/az-terraform-storage-account"
  resource_group_name = module.level_1_resource_groups.rg_output.flow_logs.name
  location            = var.location
  kind                = "StorageV2"
  sku                 = "Standard_ZRS"
  access_tier         = "Hot"
  assign_identity     = true
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, var.law_retention_days]]
  }
  naming_convention_info = merge(local.common_naming_convention_info, {
    name = "0002"
  })
  tags = merge(local.common_services_tags, {
  })
  # dependencies            = [module.common_log_analytics_workspace]
}

#Route tables for DSU
module "dsu_public_portal_spoke_route_table" {
  source              = "../../../../modules/az-terraform-route-table-routes"
  resource_group_name = module.level_1_resource_groups.rg_output.public_portal_nsg.name
  location            = var.location
  routes              = null
  naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.internet_zone_name
    tier         = var.na_tier_name
    name         = "0001"
  }
  tags = merge(local.landing_zone_tags, {})
}


module "dsu_backend_spoke_route_table" {
  source              = "../../../../modules/az-terraform-route-table-routes"
  resource_group_name = module.level_1_resource_groups.rg_output.backend_nsg.name
  location            = var.location
  routes              = null
  naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.intranet_zone_name
    tier         = var.na_tier_name
    name         = "0001"
  }
  tags = merge(local.landing_zone_tags, {})

}

module "dsu_internal_portal_spoke_route_table" {
  source              = "../../../../modules/az-terraform-route-table-routes"
  resource_group_name = module.level_1_resource_groups.rg_output.internal_portal_nsg.name
  location            = var.location
  routes              = null
  naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.intranet_zone_name
    tier         = var.na_tier_name
    name         = "0002"
  }
  tags = merge(local.landing_zone_tags, {})

}
