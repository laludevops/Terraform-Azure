
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "The SKU of the storage account."
}

variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default = null
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
