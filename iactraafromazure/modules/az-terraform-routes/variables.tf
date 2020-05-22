
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "route_table_name" {
  type        = string
  description = "Name of the route table, the route shoud be associated"
}

variable "routes" {
  description = "(Optional) Map of routes to be added to the route table"
  default     = null
  type        = map(object({
    destination_CIDR        = string
    next_hop_in_ip_address  = string  #VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None
    next_hop_type  = string
  }))
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
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
