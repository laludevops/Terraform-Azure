variable "resource_group_name" {
  description = "(required) The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "application_type" {
  description = "(required) the application type for insights to create, valid values are: ios, java, MobileCenter, Node.JS, other, phone, store and web"
  type        = string
}

variable "api_permissions" {
  description = "(required)"
  type =  map(object({
      read_permissions  = list(string)
      write_permissions = list(string)
    }))
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
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