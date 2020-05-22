#Landing zone variables
locals {
  common_tags = {
    Landing-Zone = "level0"
    location     = var.location
  }

  common_naming_convention_info = {
    project_code = var.project_code
    env          = var.env
    zone         = var.devops_zone_name
    tier         = var.na_tier_name
  }
  diag_object = {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loga_obj.id
    log                        = []
    metric                     = [["AllMetrics", true, true, var.law_retention_days]]
  }
}


data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = var.loga_workspace_name
  resource_group_name = var.loga_resource_group_name
}
module "common_resource_groups" {
  source = "../../../../modules/az-terraform-resource-group"
  resource_groups = {
    tf = {
      name     = var.resource_group_name
      location = var.location
      tags     = {}
    }
  }
}

#storage account for network watcher flow logs
module "storage_account_terraform_state" {
  source              = "../../../../modules/az-terraform-storage-account"
  resource_group_name = module.common_resource_groups.rg_output.tf.name
  location            = var.location
  kind                = var.storage_account_kind
  sku                 = var.storage_account_sku
  access_tier         = var.storage_account_tier
  assign_identity     = true
  containers = {
    "dsu-0001" = {
      name        = null
      access_type = "private"
    }
    "dsu-0002" = {
      name        = null
      access_type = "private"
    }
    "dev-0001" = {
      name        = null
      access_type = "private"
    }
    "dev-0002" = {
      name        = null
      access_type = "private"
    }
    "sit-0001" = {
      name        = null
      access_type = "private"
    }
    "sit-0002" = {
      name        = null
      access_type = "private"
    }
    "uat-0001" = {
      name        = null
      access_type = "private"
    }
    "uat-0002" = {
      name        = null
      access_type = "private"
    }
  }
  diag_object = null
  naming_convention_info = merge(local.common_naming_convention_info, {
    agency_code = var.agency_code
    name        = "0001"
  })
  tags = local.common_tags
}
