dev_backend_aks_resource_group_name	= "rg-alex-iac"
dev_backend_aks_location			= "southeastasia"
dev_backend_aks_name			= "aks"
dev_backend_aks_agent_pool_subnet_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-alex-iac/providers/Microsoft.Network/virtualNetworks/Alex_vnet/subnets/aks_subnet"
dev_backend_aks_tags				= {
    custom_tag = "Custom tag as needed"
} 
dev_backend_aks_build_name          = "build"
dev_backend_aks_node_pool_name      = "default"
dev_backend_aks_vm_size             = "Standard_D2s_v3"
dev_backend_aks_os_disk_size_gb     = 50
dev_backend_aks_max_pods            = 30
dev_backend_aks_availability_zones  = [1, 2, 3]
dev_backend_aks_enable_auto_scaling = true
dev_backend_aks_min_count           = 3
dev_backend_aks_max_count           = 3
dev_backend_aks_service_principal = {
  client_id     = "d6a8e808-552c-4879-88aa-14496c2dd71a"
  client_secret = "8bbca819-5af7-481b-9228-0216ada437c8"
}
dev_backend_aks_diag_object = {
    log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-alex-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-alex-001"
    log = [["AllLogs", true, true, 80],]
    metric = [["AllMetrics", true, true, 80], ]
}