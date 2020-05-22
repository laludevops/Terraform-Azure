
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}
variable "keyvault_id" {
  type        = string
  description = "(Required) Specifies the azure key vault id."
}
variable "enable_disk_encryption" {
  type = bool
  default = true
}

variable "location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable "instance_count" {
  type        = number
  description = "(Optional) Specifies the Number of nic resouces to be created as array."
  default     = 1
}

variable "storage_account_type" {
  type = string
}

variable "create_option" {
  type = string
}

variable "disk_iops_read_write" {
  type    = string
  default = null
}

variable "disk_mbps_read_write" {
  type    = string
  default = null
}

variable "disk_size_gb" {
  type    = string
  default = null
}

variable "zone" {
  type    = list(string)
  default = []
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
  type = object({
    name         = string
    agency_code  = string
    project_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dependencies" {
  type        = list
  description = "List of dependecies modules or resources"
  default     = null
}

