# dev ops zone aks tier variables
variable "dev_backend_aks_name" {}
variable "dev_backend_aks_build_name" {}
variable "dev_backend_aks_node_pool_name" {}
variable "dev_backend_aks_vm_size" {}
variable "dev_backend_aks_os_disk_size_gb" {}
variable "dev_backend_aks_max_pods" {}
variable "dev_backend_aks_availability_zones" {}
variable "dev_backend_aks_enable_auto_scaling" {}
variable "dev_backend_aks_min_count" {}
variable "dev_backend_aks_max_count" {}
variable "dev_backend_aks_service_principal" {}
variable "dev_backend_aks_resource_group_name" {}
variable "dev_backend_aks_location" {}
variable "dev_backend_aks_agent_pool_subnet_id" {}
variable "dev_backend_aks_tags" {}
variable "dev_backend_aks_diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    })
}
