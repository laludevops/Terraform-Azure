# Load Balancer Related ##################
variable "lb_resource_group_name" {
  description = "(Required) Map of the resource groups to create"
  type        = string
}

variable "lb_location" {
  description = "location of the resource"
}

variable "lb_subnet_id" {
  description = "subnet id of the frontend config"
  type        = string
  default     = null
}

variable "lb_public_ip_address_id" {
  description = "Publicc Ip Address for the load balancer"
  type        = string
  default     = null
}

variable "lb_static_ip" {
  description = "Static ip of the frontend config"
  type        = string
  default     = null
}

variable "lb_rules" {
  type = map(object({
    probe_port              = string
    probe_protocol          = string
    lb_port                 = string
    backend_port            = string
    load_distribution       = string
    idle_timeout_in_minutes = number
  }))
}

variable "lb_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "lb_naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    agency_code  = string
    project_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "lb_sku" {
  description = "The SKU of Azure Load Balancer. Accepted values are only Standard"
  type        = string
}

variable "lb_tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "nic_lb_association" {
  type = list(object({
    ip_configuration_name = string
    nic_id                = string
  }))
  default     = null
  description = "(Optional) Specify the nic Load balancer association for existing nic interfaces. Use this only if Nic_ids are specified"
}
#end region Load balancer



# Virtual Machine Related ##################
variable "vm_resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "vm_location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable "vm_instance_count" {
  type        = number
  description = "(Optional) Specifies the number of the Virtual Machines. Minimum 2 for vm with load balancer."
  default     = 2
}

variable "vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the Virtual Machine."
  default     = "Standard_D4s_v3"
}

variable "vm_disable_password_authentication" {
  type        = bool
  description = "(Optional) Disable passwords authentication"
  default     = true
}

variable "vm_license_type" {
  type        = string
  description = "(Optional) Specify the BYOL license type."
  default     = null
}

variable "vm_nic_ids" {
  type        = list(list(string))
  default     = null
  description = "(optional) Specify the Existing NIC configuration. Use this property if the NIC are managed outside the module"
}

variable "vm_nic_info" {
  type = object({
    subnet_id = string
    nsg_id    = string
    nics = map(object({
      public_ip_address_id = string
      is_primary           = bool
      private_ip_address   = list(string)
    }))
  })
  description = "(optional) Specify the nic_info when nic_ids are not passed. "
}

variable "vm_os_type" {
  type        = string
  description = "(Optional) Specify the OS type."
  default     = "windows"
}

variable "vm_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "(Optional) To provision vm from an Azure Platform Image."
  default     = null
}

variable "vm_custom_image" {
  description = "(Optional) To provision vm from a custom Image."
  type = object({
    name                = string
    resource_group_name = string
  })
  default = null
}

variable "vm_os_profile_windows_config" {
  type        = map(string)
  description = "(Optional) To configure windows profile."
  default = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true                      # Required VM Agent to execute Azure virtual machine extensions.
    timezone                  = "Singapore Standard Time" # Specifies the time zone of the virtual machine, the possible values are defined http://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  }
}

variable "vm_marketplace" {
  description = "specify the market place vm image"
  type = object({
    name      = string
    publisher = string
    product   = string
  })
  default = null
}

variable "vm_admin_username" {
  type        = string
  description = "(Required) OS admin name for remote access."
}

variable "vm_admin_password" {
  type        = string
  description = "(Required) OS admin password for remote access."
}

variable "vm_boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = true
}

variable "mvm_anagedidentity_type" {
  type        = string
  description = "(Optional) The Managed Service Identity Type of this Virtual Machine. Default to SystemAssigned"
  default     = "SystemAssigned"
}

variable "vm_managedidentity_ids" {
  type        = list
  description = "(Optional) The Managed Service Identity Ids of this Virtual Machine."
  default     = null
}

variable "vm_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "vm_naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    agency_code  = string
    project_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "vm_tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "vm_tls_private_key_file" {
  type        = string
  default     = null
  description = "(optional)Specify the filename with private key file for the Linux vm for ssh"
}

variable "vm_disk_encryption_info" {
  description = "(Required) Specify the disk encryption info"
  type = object({
    encrypt_operation          = string
    vault_url                  = string
    vault_resource_id          = string
    vault_encryption_algorithm = string
    vault_volume_type          = string
  })
}

variable "dependencies" {
  description = "List of dependecies modules or resources"
  default     = null
}
