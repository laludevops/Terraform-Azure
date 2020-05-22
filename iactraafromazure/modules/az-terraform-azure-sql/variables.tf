
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "adminuser" {
  type        = string
  default     = null
  description = "(Optional)Administrator user name for sql server"
}

variable "adminpassword" {
  type        = string
  default     = null
  description = "(Optional)Administrator user name for sql server"
}

variable "enable_managed_identity" {
  type        = bool
  default     = true
  description = "(Optional)Enable system assigned Managed identity"
}

variable "databases" {
  description = "(Optional)Map of databases to be created"
  default     = null
  type = map(object({
    name                             = string
    collation                        = string
    edition                          = string
    requested_service_objective_name = string
    max_size_bytes                   = string
  }))
}

variable "firewall_rules" {
  description = "(Optional)Map of firewall_rules to be created"
  default     = {}
  type = map(object({
    start_ipaddress = string
    end_ipaddress   = string
  }))
}

variable "vnet_rules" {
  description = "(Optional)Map of firewall_rules to be created"
  type = map(object({
    subnet_id   = string
  }))
}

variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
              agency_code   = string
              project_code  = string
              env           = string
              zone          = string 
              tier          = string
    })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}
