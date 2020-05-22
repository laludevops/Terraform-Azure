variable "resource_group_name" {
  description = "(Required) Name of the resource group where to create the aks"
  type        = string
}

variable "location" {
  description = "(Required) Define the region where the resource groups will be created"
  type        = string
}

variable "enable_psp" {
  description = "(Required) Enable Pod Security Policy"
  default     = false
  type        = bool
}

variable "enable_rbac" {
  description = "(Required) Enable RBAC"
  default     = true
  type        = bool
}


variable "aks_node_rg" {
  description = "(Optional) The name of the Resource Group where the the Kubernetes Nodes should exist."
  type        = string
  default     = null
}

variable "api_server_authorized_ip_ranges" {
  description = "(Optional) List of ip ranges that master nodes can access "
  type        = list(string)
  default     = null
}

variable "agent_pool_subnet_id" {
  description = "(Required) The ID of the Subnet where the Agents in the Pool should be provisioned."
}

variable "default_node_pool" {
  description = "(Optional) List of agent_pools profile for multiple node pools"
  type = object({
    name                = string
    vm_size             = string
    availability_zones  = list(number)
    enable_auto_scaling = bool
    max_pods            = number
    os_disk_size_gb     = number
    min_count           = number
    max_count           = number
  })
  default = {
    name                = "default"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    max_pods            = 30
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
  }
}

variable "linux_admin_username" {
  description = "(Optional) User name for authentication to the Kubernetes linux agent virtual machines in the cluster."
  type        = string
  default     = "azureuser"
}

variable "kubernetes_version" {
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster"
  default     = ""
}

variable "aad_profile" {
  description = "specify the Azure Active directory profile"
  default = null
  type = object({
    client_id     = string
    server_id     = string
    server_secret = string
    tenant_id     = string
  })
}

variable "addon_profile" {
  description = "(Optional) AddOn Profile block."
  type = object({
    enable_oms_agent                = bool
    enable_http_application_routing = bool
    enable_kube_dashboard           = bool
    enable_azure_policy             = bool
  })
  default = {
    enable_oms_agent                = true
    enable_http_application_routing = false
    enable_kube_dashboard           = false
    enable_azure_policy             = true
  }
}

variable "network_profile" {
  description = "(Optional) Sets up network profile for Advanced Networking."
  default = {
    # Use azure-cni for advanced networking
    network_plugin = "azure"
    # Sets up network policy to be used with Azure CNI. Currently supported values are calico and azure." 
    network_policy     = "azure"
    service_cidr       = "10.100.0.0/16"
    dns_service_ip     = "10.100.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    # Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Use standard for when enable agent_pools availability_zones.
    load_balancer_sku = "Standard"
  }
}

variable "service_principal" {
  description = "(Required) The Service Principal to create aks."
  type = object({
    client_id     = string
    client_secret = string
  })
}

variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  type = object({
    log_analytics_workspace_id  = string
    log                         = list(tuple([string, bool, bool, number]))
    metric                      = list(tuple([string, bool, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
              agency_code  = string
              project_code  = string
              env           =  string
              zone =  string 
              tier = string
    })
}

variable "tags" {
  type =  map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}


