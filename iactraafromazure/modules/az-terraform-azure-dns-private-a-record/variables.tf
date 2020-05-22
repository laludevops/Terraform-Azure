
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "dns_zone_name" {
  type        = string
  description = "Name of the route table, the route shoud be associated"
}

variable "a_records" {
  description = "(Required) Specify the A records info for the dns."
  type = map(object({
    a_record_name = string
    ips           = list(string)
    ttl           = number
  }))
}


variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              project_code  = string
              agency_code  = string
              env           =  string
              zone          =  string 
              tier          = string
    })
}

variable "tags" {
  type        =  map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}