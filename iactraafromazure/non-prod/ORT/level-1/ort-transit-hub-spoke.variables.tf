variable "transit_hub_spoke_vnet_name" {}
variable "transit_hub_spoke_vnet_resource_group_name" {}
variable "transit_hub_route_table_resource_group_name" {}

variable "transit_hub_nsg_resource_group_name" {}


variable "transit_hub_app_0001_tier_cidr" {}

variable "transit_hub_app_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_app_0001_tier_nsg_inbound_rules" {}

variable "transit_hub_app_0001_tier_nsg_outbound_rules" {}

variable "transit_hub_app_0001_tier_delegation" {
  default = null
}


variable "transit_hub_tmt_0001_tier_cidr" {}

variable "transit_hub_tmt_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_tmt_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "transit_hub_tmt_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "transit_hub_tmt_0001_tier_delegation" {
  default = null
}


variable "transit_hub_app_0002_tier_cidr" {}

variable "transit_hub_app_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_app_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "transit_hub_app_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "transit_hub_app_0002_tier_delegation" {
  default = null
}


variable "transit_hub_tmt_0002_tier_cidr" {}

variable "transit_hub_tmt_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_tmt_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "transit_hub_tmt_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "transit_hub_tmt_0002_tier_delegation" {
  default = null
}

variable "transit_hub_tmt_0003_tier_cidr" {}

variable "transit_hub_tmt_0003_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_tmt_0003_tier_nsg_inbound_rules" {
  default = []
}

variable "transit_hub_tmt_0003_tier_nsg_outbound_rules" {
  default = []
}

variable "transit_hub_tmt_0003_tier_delegation" {
  default = null
}


variable "transit_hub_ingress_0001_tier_cidr" {}

variable "transit_hub_ingress_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_ingress_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "transit_hub_ingress_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "transit_hub_ingress_0001_tier_delegation" {
  default = null
}


variable "transit_hub_egress_0001_tier_cidr" {}

variable "transit_hub_egress_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "transit_hub_egress_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "transit_hub_egress_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "transit_hub_egress_0001_tier_delegation" {
  default = null
}
