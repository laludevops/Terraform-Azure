variable "resource_group_name" {
  description = "(Required) Map of the resource groups to create"
  type        = string
}

variable "location" {
  description = "location of the resource"
}

variable "subnet_id" {
  description = "subnet id of the frontend config"
  type        = string
  default     = null
}

variable "public_ip_address_id" {
  description = "Publicc Ip Address for the load balancer"
  type        = string
  default     = null
}

variable "static_ip" {
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

variable "sku" {
  description = "The SKU of Azure Load Balancer. Accepted values are only Standard"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dependencies" {
  description = "List of dependecies modules or resources"
  default     = null
}


