
variable "dev_backend_azsql_name" {
  type        = string
}

variable "dev_backend_azsql_resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "dev_backend_azsql_location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "dev_backend_azsql_adminuser" {
  type        = string
  default     = null
  description = "(Optional)Administrator user name for sql server"
}

variable "dev_backend_azsql_dev_backend_adminpassword" {
  type        = string
  default     = null
  description = "(Optional)Administrator user name for sql server"
}

variable "dev_backend_azsql_enable_managed_identity" {
  type        = bool
  default     = true
  description = "(Optional)Enable system assigned Managed identity"
}

variable "dev_backend_azsql_databases" {
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

variable "dev_backend_azsql_firewall_rules" {
  description = "(Optional)Map of firewall_rules to be created"
  default     = {}
  type = map(object({
    start_ipaddress = string
    end_ipaddress   = string
  }))
}

variable "dev_backend_azsql_vnet_rules" {
  description = "(Optional)Map of firewall_rules to be created"
  default = {}
  type = map(object({
    subnet_id   = string
  }))
}

variable "dev_backend_azsql_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "dev_backend_azsql_tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}
