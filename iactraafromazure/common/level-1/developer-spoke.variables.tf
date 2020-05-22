variable "developer_spoke_vnet_name" {}
variable "developer_spoke_vnet_resource_group_name" {}

variable "developer_dev_tier_cidr" {}

variable "developer_dev_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "developer_dev_tier_nsg_inbound_rules" {
  default = []
}

variable "developer_dev_tier_nsg_outbound_rules" {
  default = []
}

variable "developer_dev_tier_delegation" {
  default = null
}

variable "developer_spoke_route_table_resource_group_name" {}

variable "developer_spoke_nsg_resource_group_name" {}