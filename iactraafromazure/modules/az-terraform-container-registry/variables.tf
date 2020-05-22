

variable "resource_group_name" {
  description = "(Required) Map of the resource groups to create"
  type        = string
}

variable "location" {
  description = "(Required) location of the resource"
  type        = string
}

variable "sku" {
  description = "(Required)specify the sku for the acr (Basic, Standard and Premium)"
  type        = string
}

variable "vnet_rule" {
  description = "(Optional)contains the virtual network rules set"
  default     = null
  # type = list(list(string))
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
  type = object({
    name         = string
    project_code = string
    agency_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}



