resource "azurerm_kubernetes_cluster" "aks_obj" {
  # lifecycle {
  #   ignore_changes = [node_count]
  # }
  
  name                                               = module.aks_name.naming_convention_output[var.naming_convention_info.name].names.0
  dns_prefix                                         = module.aks_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name                                = var.resource_group_name
  location                                           = var.location

  node_resource_group                                = var.aks_node_rg
  api_server_authorized_ip_ranges                    = var.api_server_authorized_ip_ranges
  enable_pod_security_policy                         = var.enable_psp

  linux_profile {
    admin_username = var.linux_admin_username

    ssh_key {
      key_data = trimspace(tls_private_key.key.public_key_openssh)
    }
  }

  #retrieve the latest version of Kubernetes supported by Azure Kubernetes Service if version is not set
  kubernetes_version = var.kubernetes_version != "" ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                = var.default_node_pool.name
    vm_size             = var.default_node_pool.vm_size
    availability_zones  = var.default_node_pool.availability_zones
    enable_auto_scaling = var.default_node_pool.enable_auto_scaling
    max_pods            = var.default_node_pool.max_pods
    os_disk_size_gb     = var.default_node_pool.os_disk_size_gb
    vnet_subnet_id      = var.agent_pool_subnet_id
    min_count           = var.default_node_pool.min_count
    max_count           = var.default_node_pool.max_count
    type                = "VirtualMachineScaleSets"
    enable_node_public_ip = false
  }

  service_principal {
    client_id     = var.service_principal.client_id
    client_secret = var.service_principal.client_secret
  }

  addon_profile {
    oms_agent {
      enabled                    = var.addon_profile.enable_oms_agent
      log_analytics_workspace_id = var.diag_object.log_analytics_workspace_id
    }

    http_application_routing {
      enabled = var.addon_profile.enable_http_application_routing
    }

    kube_dashboard {
      enabled = var.addon_profile.enable_kube_dashboard
    }
    
    # azure_policy {
    #   enabled      = var.addon_profile.enable_azure_policy
    # }
  }

  role_based_access_control {
    enabled =  var.enable_rbac

    # dynamic "azure_active_directory" {
    #   for_each = var.aad_profile != null && var.aad_profile != {} ? [1] : [0]

    #   content {
    #     client_app_id     =  var.aad_profile.client_id
    #     server_app_id     =  var.aad_profile.server_id
    #     server_app_secret =  var.aad_profile.server_secret
    #     tenant_id         =  var.aad_profile.tenant_id
    #   }
    # }
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    network_policy     = var.network_profile.network_policy
    service_cidr       = var.network_profile.service_cidr
    dns_service_ip     = var.network_profile.dns_service_ip
    docker_bridge_cidr = var.network_profile.docker_bridge_cidr
    load_balancer_sku  = var.network_profile.load_balancer_sku
  }

  tags = module.aks_name.naming_convention_output[var.naming_convention_info.name].tags.0
}
