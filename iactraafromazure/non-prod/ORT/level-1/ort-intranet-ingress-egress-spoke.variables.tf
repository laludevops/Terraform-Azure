variable "intranet_ingress_egress_spoke_vnet_name" {}
variable "intranet_ingress_egress_spoke_vnet_resource_group_name" {}
variable "intranet_ingress_egress_route_table_resource_group_name" {}

variable "intranet_ingress_egress_nsg_resource_group_name" {}


variable "intranet_ingress_egress_gut_0002_tier_cidr" {}

variable "intranet_ingress_egress_gut_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "intranet_ingress_egress_gut_0002_tier_nsg_inbound_rules" {}

variable "intranet_ingress_egress_gut_0002_tier_nsg_outbound_rules" {}

variable "intranet_ingress_egress_gut_0002_tier_delegation" {
  default = null
}


variable "intranet_ingress_egress_tmt_0006_tier_cidr" {}

variable "intranet_ingress_egress_tmt_0006_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "intranet_ingress_egress_tmt_0006_tier_nsg_inbound_rules" {
  default = []
}

variable "intranet_ingress_egress_tmt_0006_tier_nsg_outbound_rules" {
  default = []
}

variable "intranet_ingress_egress_tmt_0006_tier_delegation" {
  default = null
}


variable "intranet_ingress_egress_tmt_0004_tier_cidr" {}

variable "intranet_ingress_egress_tmt_0004_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "intranet_ingress_egress_tmt_0004_tier_nsg_inbound_rules" {
  default = []
}

variable "intranet_ingress_egress_tmt_0004_tier_nsg_outbound_rules" {
  default = []
}

variable "intranet_ingress_egress_tmt_0004_tier_delegation" {
  default = null
}


variable "intranet_ingress_egress_ingress_0002_tier_cidr" {}

variable "intranet_ingress_egress_ingress_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "intranet_ingress_egress_ingress_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "intranet_ingress_egress_ingress_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "intranet_ingress_egress_ingress_0002_tier_delegation" {
  default = null
}


variable "intranet_ingress_egress_egress_0002_tier_cidr" {}

variable "intranet_ingress_egress_egress_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "intranet_ingress_egress_egress_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "intranet_ingress_egress_egress_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "intranet_ingress_egress_egress_0002_tier_delegation" {
  default = null
}


variable "intranet_ingress_egress_tmt_0005_tier_cidr" {}

variable "intranet_ingress_egress_tmt_0005_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "intranet_ingress_egress_tmt_0005_tier_nsg_inbound_rules" {
  default = []
}

variable "intranet_ingress_egress_tmt_0005_tier_nsg_outbound_rules" {
  default = []
}

variable "intranet_ingress_egress_tmt_0005_tier_delegation" {
  default = null
}
