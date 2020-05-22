locals {
  # For naming convention purpose
  dev_backend_aks_naming_convention_info = {
    name         = var.dev_backend_aks_name
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.internet_zone_name
    tier         = var.cache_tier_name
  }
}

module "dev_backend_aks_build" {
  source               = "../../../../modules/az-terraform-azure-kubernetes-service"
  resource_group_name  = var.dev_backend_aks_resource_group_name
  location             = var.dev_backend_aks_location
  agent_pool_subnet_id = var.dev_backend_aks_agent_pool_subnet_id
  service_principal    = var.dev_backend_aks_service_principal

  default_node_pool = {
    name                = var.dev_backend_aks_node_pool_name
    vm_size             = var.dev_backend_aks_vm_size
    os_disk_size_gb     = var.dev_backend_aks_os_disk_size_gb
    max_pods            = var.dev_backend_aks_max_pods
    availability_zones  = var.dev_backend_aks_availability_zones
    enable_auto_scaling = var.dev_backend_aks_enable_auto_scaling
    min_count           = var.dev_backend_aks_min_count
    max_count           = var.dev_backend_aks_max_count
  }

  diag_object            = var.dev_backend_aks_diag_object
  naming_convention_info = local.dev_backend_aks_naming_convention_info
  tags                   = var.dev_backend_aks_tags
}

