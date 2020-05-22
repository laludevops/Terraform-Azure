variable "internet_ingress_egress_spoke_vnet_name" {}
variable "internet_ingress_egress_spoke_vnet_resource_group_name" {}
variable "internet_ingress_egress_route_table_resource_group_name" {}

variable "internet_ingress_egress_nsg_resource_group_name" {}


variable "internet_ingress_egress_gut_0001_tier_cidr" {}

variable "internet_ingress_egress_gut_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "internet_ingress_egress_gut_0001_tier_nsg_inbound_rules" {}

variable "internet_ingress_egress_gut_0001_tier_nsg_outbound_rules" {}

variable "internet_ingress_egress_gut_0001_tier_delegation" {
  default = null
}


variable "internet_ingress_egress_tmt_0001_tier_cidr" {}

variable "internet_ingress_egress_tmt_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "internet_ingress_egress_tmt_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "internet_ingress_egress_tmt_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "internet_ingress_egress_tmt_0001_tier_delegation" {
  default = null
}


variable "internet_ingress_egress_tmt_0003_tier_cidr" {}

variable "internet_ingress_egress_tmt_0003_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "internet_ingress_egress_tmt_0003_tier_nsg_inbound_rules" {
  default = []
}

variable "internet_ingress_egress_tmt_0003_tier_nsg_outbound_rules" {
  default = []
}

variable "internet_ingress_egress_tmt_0003_tier_delegation" {
  default = null
}


variable "internet_ingress_egress_ingress_0001_tier_cidr" {}

variable "internet_ingress_egress_ingress_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "internet_ingress_egress_ingress_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "internet_ingress_egress_ingress_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "internet_ingress_egress_ingress_0001_tier_delegation" {
  default = null
}


variable "internet_ingress_egress_egress_0001_tier_cidr" {}

variable "internet_ingress_egress_egress_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "internet_ingress_egress_egress_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "internet_ingress_egress_egress_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "internet_ingress_egress_egress_0001_tier_delegation" {
  default = null
}


variable "internet_ingress_egress_tmt_0002_tier_cidr" {}

variable "internet_ingress_egress_tmt_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "internet_ingress_egress_tmt_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "internet_ingress_egress_tmt_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "internet_ingress_egress_tmt_0002_tier_delegation" {
  default = null
}

