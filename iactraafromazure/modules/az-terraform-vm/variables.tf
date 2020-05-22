
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable "instance_count" {
  type        = number
  description = "(Optional) Specifies the number of the Virtual Machines."
  default     = 1
}

variable "vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the Virtual Machine."
  default     = "Standard_D4s_v3"
}

variable "license_type" {
  type        = string
  description = "(Optional) Specify the BYOL license type."
  default     = null
}

variable "nic_info" {
  type = object({
    subnet_id = string
    nsg_id    = string
    nics = map(object({
      public_ip_address_id = string
      is_primary           = bool
      private_ip_address   = list(string)
    }))
  })
  default     = null
  description = "(optional) Specify the nic_info when nic_ids are not passed. "
}

variable "os_type" {
  type        = string
  description = "(Optional) Specify the OS type."
  default     = "windows"
}

variable "image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "(Optional) To provision vm from an Azure Platform Image."
  default     = null
}

variable "os_disk" {
  type = object({
    type          = string
    caching       = string
    create_option = string
  })

  default = {
    type          = "Standard_LRS"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
}

variable "custom_image_id" {
  type        = string
  default     = null
  description = "(Optional) Specify the custom image id supports managed image & shared gallery"
}

# variable "gallery_image" {
#   description = "(Optional) To provision vm from a custom Image."
#   type = object({
#     name                = string
#     resource_group_name = string
#     version             = string
#     gallery_name        = string
#   })
#   default = null
# }

# variable "custom_image" {
#   description = "(Optional) To provision vm from a custom Image."
#   type = object({
#     name                = string
#     resource_group_name = string
#   })
#   default = null
# }

variable "os_profile_windows_config" {
  type        = map(string)
  description = "(Optional) To configure windows profile."
  default = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true                      # Required VM Agent to execute Azure virtual machine extensions.
    timezone                  = "Singapore Standard Time" # Specifies the time zone of the virtual machine, the possible values are defined http://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  }
}

variable "marketplace" {
  description = "specify the market place vm image"
  type = object({
    name      = string
    publisher = string
    product   = string
  })
  default = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "(Optional) Disable passwords authentication"
  default     = true
}

variable "admin_username" {
  type        = string
  description = "(Required) OS admin name for remote access."
}

variable "admin_password" {
  type        = string
  description = "(Required) OS admin password for remote access."
}

variable "boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = true
}

variable "managedidentity_type" {
  type        = string
  description = "(Optional) The Managed Service Identity Type of this Virtual Machine. Default to SystemAssigned"
  default     = "SystemAssigned"
}

variable "managedidentity_ids" {
  type        = list
  description = "(Optional) The Managed Service Identity Ids of this Virtual Machine."
  default     = null
}

variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  # type = object({
  #   name         = string
  #   agency_code  = string
  #   project_code = string
  #   env          = string
  #   zone         = string
  #   tier         = string
  # })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "tls_private_key" {
  description = "(optional) Specify the with private key for the Linux vm for ssh"
  type        = string
  default     = null
}

variable "nic_ids" {
  description = "(Optional) Specify the Network Interface cards detail assigned to the vm instance. This takes precedence when both nic_ids and nic_info is passed"
  type        = list(list(string))
  default     = null
}

variable "enable_disk_encryption" {
  type    = bool
  default = true
}


variable "disk_encryption_info" {
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

variable "domain_info" {
  type = object({
    active_directory_domain   = string
    active_directory_username = string
    active_directory_password = string
    oupath                    = string
  })
  default     = null
  description = "(Optional) Specify the domain parameters for the vms domain join"
}
