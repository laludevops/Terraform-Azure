
#app Tier privates
locals {
  devops_zone_app_tier_naming_convention_info = merge(local.devops_zone_naming_convention_info, {
    tier = var.app_tier_name
  })
  devops_zone_app_tier_tags = merge(local.landing_zone_level_tags, {})
}

module "common_devops_spoke_aks" {
  source               = "../../modules/az-terraform-azure-kubernetes-service"
  resource_group_name  = var.common_devops_aks_resource_group_name
  location             = var.common_devops_aks_location
  agent_pool_subnet_id = data.terraform_remote_state.common_level_1.devops_aks_tier_info.id
  service_principal = {
    client_id     = var.common_devops_aks_location.client_id
    client_secret = var.common_devops_aks_location.client_secret
  }
  default_node_pool = {
    name                = var.common_devops_aks_node_pool_name
    vm_size             = var.common_devops_aks_vm_size
    os_disk_size_gb     = var.common_devops_aks_os_disk_size_gb
    max_pods            = var.common_devops_aks_max_pods
    availability_zones  = var.common_devops_aks_availability_zones
    enable_auto_scaling = var.common_devops_aks_enable_auto_scaling
    min_count           = var.common_devops_aks_min_count
    max_count           = var.common_devops_aks_max_count
  }
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, 80]]
    metric                     = [["AllMetrics", true, true, 80]]
  }
  naming_convention_info = merge(local.devops_zone_app_tier_naming_convention_info, {
    name = var.aks_build_name
  })
  tags = merge(local.devops_zone_app_tier_tags, {})
}

