
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  description = "The name of the location."
}

variable "ase_id" {
  type        = string
  default     = null
  description = "(Optional)ID of the App Service Environment"
}

variable "max_worker_count" {
  type        = number
  default     = 1
  description = "(Optional)No of maximum elastic workers"
}

variable "sku" {
  type = object({
    tier     = string
    size     = string
    capacity = number
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


variable "enable_independent_app_scaling" {
  type        = bool
  default     = false
}
