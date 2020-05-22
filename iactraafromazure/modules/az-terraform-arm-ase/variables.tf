
variable "kind" {
  description = "(Required) Kind of resource. Possible value are ASEV2"
  type        = string
  default     = "ASEV2"
}

variable "location" {
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the ASE"
}

variable "vnet_id" {
  description = "(Required) Name of the Virtual Network for the ASE"
}

variable "subnet_name" {
  description = "(Required) Subnet within the Virtual Network assign for ASE "
  type        = string
}

variable "internalLoadBalancingMode" {
  description = "(Required) Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment. - None, Web, Publishing. Possible value are 3 = Internal Load Balancer | 0 = External Load Balancer   "
  type        = int
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    project_code = string
    agency_code  = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  description = "(Required) map of tags for the deployment"
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
