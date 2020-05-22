
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
  description = "(Optional) Specifies the Number of nic resouces to be created as array."
  default     = 1
}

variable "dns_servers" {
  type    = list(string)
  default = null
}

variable "nsg_id" {
  type        = string
  description = "specify the nsg id for the NIC card"
}

variable "subnet_id" {
  type        = string
  description = "specify the subnet id for the nic"
}

variable "nic_info" {
  type = map(object({
    public_ip_address_id = string
    is_primary           = bool
    private_ip_address   = list(string)
  }))
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

variable "dependencies" {
  type        = list
  description = "List of dependecies modules or resources"
  default     = null
}

