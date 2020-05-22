
variable "dev_internet_app_asp_name" {
  type        = string
}

variable "dev_internet_app_asp_resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "dev_internet_app_asp_location" {
  type        = string
  description = "The name of the location."
}

variable "dev_internet_app_asp_max_worker_count" {
  type        = number
  default     = 1
  description = "(Optional)No of maximum elastic workers"
}

variable "dev_internet_app_asp_sku" {
  type = object({
    tier     = string
    size     = string
    capacity = number
  })
}

variable "dev_internet_app_asp_tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}


## start ase

variable "dev_internet_app_ase_name" {
  type        = string
}

variable "dev_internet_app_ase_kind" {
  description = "(Required) Kind of resource. Possible value are ASEV2"
  type        = string
  default     = "ASEV2"
}

variable "dev_internet_app_ase_location" {
  description = "(Required) Resource Location"
}

variable "dev_internet_app_ase_resource_group_name" {
  description = "(Required) Resource group of the ASE"
}

variable "dev_internet_app_ase_vnet_id" {
  description = "(Required) Name of the Virtual Network for the ASE"
}

variable "dev_internet_app_ase_subnet_name" {
  description = "(Required) Subnet within the Virtual Network assign for ASE "
  type        = string
}

variable "dev_internet_app_ase_internalLoadBalancingMode" {
  description = "(Required) Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment. - None, Web, Publishing. Possible value are 3 = Internal Load Balancer | 0 = External Load Balancer   "
  type        = string
}

variable "dev_internet_app_ase_tags" {
  description = "(Required) map of tags for the deployment"
}
