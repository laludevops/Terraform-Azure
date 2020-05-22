
variable "resource_group_name" {
  description = "(Required) Map of the resource groups to create"
  type        = string
}

variable "location" {
  description = "location of the resource"
}

variable "nsg_info" {
  description = "map structure for the subnets to be created"
  type = map(object({
    nsg_inbound   = list(list(string))
    nsg_outbound  = list(list(string))
  }))
  default = null
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
              project_code  = string
              agency_code  = string
              env           =  string
              zone =  string 
              tier = string
    })
}

variable "tags" {
  type =  map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "netwatcher" {
  default = null
  type    = object({
        network_watcher_name    = string
        resource_group_name     = string
        storage_account_id      = string
        retention_period_days   = number
        law = object({
          workspace_id  = string
          location      = string
          id            = string
        })
      })
}

variable "dependencies" {
  type = list
  description = "List of dependecies modules or resources"
  default = null
}