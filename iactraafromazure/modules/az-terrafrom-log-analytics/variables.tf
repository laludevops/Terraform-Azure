variable "resource_group" {
  description = "(Required) Resource groups map"
}

variable "location" {
  description = "(Required) Location of the resources"
}

variable "solution_plan_map" {
  description = "(Optional) Map structure containing the list of solutions to be enabled.See https://docs.microsoft.com/en-us/azure/azure-monitor/insights/solutions-inventory"
  type = map(any)
}

variable "sku" {
  description = "(Required) sku for log analytics workspace. (Premium, Standard, Standalone, Unlimited, and PerGB2018)"
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
              agency_code  = string
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

variable "dependencies" {
  description = "List of dependecies modules or resources"
  default = null
}