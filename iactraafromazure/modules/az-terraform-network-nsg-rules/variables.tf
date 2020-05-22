
variable "resource_group_name" {
  description = "(Required)resource grups of NSG"
  type        = string
}

variable "nsg_name" {
  description = "Name of the NSG. NSG shld be in the same resource group"
}


variable "inbound_rules" {
  type = list(object({
    priority                                   = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    destination_port_range                     = string
    source_address_prefix                      = string
    destination_address_prefix                 = string
    source_application_security_group_ids      = list(string)
    destination_application_security_group_ids = list(string)
  }))
}

variable "outbound_rules" {
  type = list(object({
    priority                                   = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    destination_port_range                     = string
    source_address_prefix                      = string
    destination_address_prefix                 = string
    source_application_security_group_ids      = list(string)
    destination_application_security_group_ids = list(string)
  }))
}


# variable "inbound_rules" {
#   description = "map structure for the subnets to be created"
#   #priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, source_application_security_group_ids, destination_application_security_group_ids
#   type = list(tuple([string, string, string, string, string, string, string, string, list(string), list(string)]))
# }


# variable "outbound_rules" {
#   description = "map structure for the subnets to be created"
#   #priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, source_application_security_group_ids, destination_application_security_group_ids
#   type = list(tuple([string, string, string, string, string, string, string, string, list(string), list(string)]))
# }


variable "dependencies" {
  type        = list
  description = "List of dependecies modules or resources"
  default     = null
}
