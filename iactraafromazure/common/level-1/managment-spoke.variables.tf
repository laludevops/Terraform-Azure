variable "management_spoke_vnet_name" {}

variable "management_spoke_vnet_resource_group_name" {}

variable "management_tmt_0001_tier_cidr" {}

variable "management_tmt_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "management_tmt_0001_tier_nsg_inbound_rules" {}

variable "management_tmt_0001_tier_nsg_outbound_rules" {}

variable "management_tmt_0001_tier_delegation" {
  default = null
}

variable "management_tmt_0002_tier_cidr" {}

variable "management_tmt_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "management_tmt_0002_tier_nsg_inbound_rules" {}

variable "management_tmt_0002_tier_nsg_outbound_rules" {}

variable "management_tmt_0002_tier_delegation" {
  default = null
}

variable "management_tmt_0003_tier_cidr" {}

variable "management_tmt_0003_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "management_tmt_0003_tier_nsg_inbound_rules" {}

variable "management_tmt_0003_tier_nsg_outbound_rules" {}

variable "management_tmt_0003_tier_delegation" {
  default = null
}

variable "management_hsm_tier_cidr" {}

variable "management_hsm_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "management_hsm_tier_nsg_inbound_rules" {}

variable "management_hsm_tier_nsg_outbound_rules" {}

variable "management_hsm_tier_delegation" {
  default = null
}

variable "management_db_tier_cidr" {}

variable "management_db_tier_service_endpoints" {
  type = list(string)
}

variable "management_db_tier_nsg_inbound_rules" {
  default = []
}

variable "management_db_tier_nsg_outbound_rules" {
  default = []
}

variable "management_db_tier_delegation" {
  default = null
}

variable "management_tmt_0004_tier_cidr" {}

variable "management_tmt_0004_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "management_tmt_0004_tier_nsg_inbound_rules" {
  default = []
}

variable "management_tmt_0004_tier_nsg_outbound_rules" {
  default = []
}

variable "management_tmt_0004_tier_delegation" {
  default = null
}

variable "management_tmt_0005_tier_cidr" {}

variable "management_tmt_0005_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "management_tmt_0005_tier_nsg_inbound_rules" {
  default = []
}

variable "management_tmt_0005_tier_nsg_outbound_rules" {
  default = []
}

variable "management_tmt_0005_tier_delegation" {
  default = null
}

variable "management_tmt_0006_tier_cidr" {}

variable "management_tmt_0006_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "management_tmt_0006_tier_nsg_inbound_rules" {
  default = []
}

variable "management_tmt_0006_tier_nsg_outbound_rules" {
  default = []
}

variable "management_tmt_0006_tier_delegation" {
  default = null
}

variable "management_spoke_route_table_resource_group_name" {}

variable "management_spoke_nsg_resource_group_name" {}
