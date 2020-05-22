
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

# #Log analytics workspace for common subscription
# module "common_log_analytics_workspace" {
#   source         = "../../../modules/az-terrafrom-log-analytics"
#   resource_group = var.loga_resource_group_name
#   location       = var.location
#   sku            = "Free"
#   naming_convention_info = merge(local.common_naming_convention_info, {
#     name = "gcci"
#   })

#   tags = merge(local.common_services_tags, {
#   })
#   solution_plan_map = {
#     ADAssessment = {
#       "publisher" = "Microsoft"
#       "product"   = "OMSGallery/ADAssessment"
#     },
#     ADReplication = {
#       "publisher" = "Microsoft"
#       "product"   = "OMSGallery/ADReplication"
#     },
#     AgentHealthAssessment = {
#       "publisher" = "Microsoft"
#       "product"   = "OMSGallery/AgentHealthAssessment"
#     },
#     DnsAnalytics = {
#       "publisher" = "Microsoft"
#       "product"   = "OMSGallery/DnsAnalytics"
#     },
#     KeyVaultAnalytics = {
#       "publisher" = "Microsoft"
#       "product"   = "OMSGallery/KeyVaultAnalytics"
#     }
#   }
# }

#storage account for network watcher flow logs
module "storage_account_network_watcher_logs" {
  source              = "../../../modules/az-terraform-storage-account"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.flow_logs.name
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

# #automation account
# module "azure_automation_account" {
#   source              = "../../../modules/az-terraform-azure-automation-account"
#   resource_group_name = var.automation_account_resource_group_name
#   location            = var.location
#   diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = null
#     metric                     = [["AllMetrics", true, true, var.law_retention_days]]
#   }
#   naming_convention_info = merge(local.common_naming_convention_info, {
#     name = "account"
#   })
#   tags = merge(local.common_services_tags, {
#   })
# }

module "azure_backup" {
  source              = "../../../modules/az-terraform-azure-backup"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.rsv.name
  location            = var.location
  sku                 = "Standard"
  enable_soft_delete  = true
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = []
  }
  naming_convention_info = merge(local.common_naming_convention_info, {
    zone = var.intranet_zone_name
    name = "0001"
  })
  tags = merge(local.common_services_tags, {
  })
}
data "azurerm_client_config" "current" {}

#Azure Key Vault for Common Subscription
module "common_azure_key_vault" {
  source              = "../../../modules/az-terraform-key-vault"
  resource_group_name = module.ort_level_1_resource_groups.rg_output.kv.name
  location            = var.location
  sku                 = "premium"
  akv_policies = {
    sp1 = {
      object_id          = data.azurerm_client_config.current.object_id
      tenant_id          = data.azurerm_client_config.current.tenant_id
      key_permissions    = ["create", "get", "delete", "update"]
      secret_permissions = ["get", "list", "set"]
    }
  }
  network_acls = [{
    bypass         = "AzureServices"
    default_action = "Allow"
    ip_rules       = null
    subnet_ids     = []
  }]
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, var.law_retention_days]]
    metric                     = [["AllMetrics", true, true, var.law_retention_days]]
  }
  naming_convention_info = merge(local.common_naming_convention_info, {
    #dont have more than 2 characters
    name = "0001"
  })
  tags = merge(local.common_services_tags, {
  })
  dependencies = []
}
