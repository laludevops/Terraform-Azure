#Landing zone variables
locals {
  loga_id           = data.azurerm_log_analytics_workspace.loga_obj.id
  loga_workspace_id = data.azurerm_log_analytics_workspace.loga_obj.workspace_id
  landing_zone_level_tags = {
    Landing-Zone = "level1"
    Location     = var.location
  }
}

#zone level privates
locals {
  devops_zone_naming_convention_info = {
    project_code = var.project_code
    agency_code  = var.agency_code
    env          = var.env
    zone         = var.devops_zone_name
    "tier"       = var.na_tier_name
  }
  common_services_tags = merge(local.landing_zone_level_tags, {})
}

data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = var.loga_workspace_name
  resource_group_name = var.loga_resource_group_name
}

module "devops_acr" {
  source              = "../../modules/az-terraform-container-registry"
  resource_group_name = var.devops_acr_resource_group_name
  location            = var.devops_acr_location
  sku                 = var.devops_acr_sku
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, 80], ]
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  naming_convention_info = merge(local.devops_zone_naming_convention_info, { name = var.devops_acr_name })
  tags                   = local.common_services_tags
}
