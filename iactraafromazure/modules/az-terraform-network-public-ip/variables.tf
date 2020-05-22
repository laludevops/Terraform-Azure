
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "allocation_method" {
  type        = string
  default     = "Dynamic"
  description = "Allocation method of IP."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "Domain name lable"
}

variable "zones" {
  type        = list(string)
  default     = ["1"]
  description = "Domain name lable"
}

variable "sku" {
  description = "The SKU of public ip - Basic/Standard"
  type        = string
  default     = "Basic"
}

variable "fqdn" {
  description = "Reverse FQDN "
  type        = string
  default     = null
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
