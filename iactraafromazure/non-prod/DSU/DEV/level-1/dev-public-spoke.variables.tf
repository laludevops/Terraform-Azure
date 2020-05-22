variable "public_portal_spoke_vnet_name" {}
variable "public_portal_spoke_vnet_resource_group_name" {}
variable "public_portal_route_table_resource_group_name" {}

variable "public_portal_nsg_resource_group_name" {}

variable "public_portal_web_0001_tier_cidr" {
}

variable "public_portal_web_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "public_portal_web_0001_tier_nsg_inbound_rules" {

}

variable "public_portal_web_0001_tier_nsg_outbound_rules" {

}

variable "public_portal_web_0001_tier_delegation" {
  default = null
}

variable "public_portal_app_0003_tier_cidr" {
}

variable "public_portal_app_0003_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "public_portal_app_0003_tier_nsg_inbound_rules" {

}

variable "public_portal_app_0003_tier_nsg_outbound_rules" {

}

variable "public_portal_app_0003_tier_delegation" {
  default = null
}

variable "public_portal_app_0001_tier_cidr" {}

variable "public_portal_app_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "public_portal_app_0001_tier_nsg_inbound_rules" {


}
variable "public_portal_app_0001_tier_nsg_outbound_rules" {

}

variable "public_portal_app_0001_tier_delegation" {
  default = null
}

variable "public_portal_gut_0001_tier_cidr" {}

variable "public_portal_gut_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "public_portal_gut_0001_tier_nsg_inbound_rules" {
}

variable "public_portal_gut_0001_tier_nsg_outbound_rules" {
}

variable "public_portal_gut_0001_tier_delegation" {
  default = null
}

variable "public_portal_int_0001_tier_cidr" {}

variable "public_portal_int_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "public_portal_int_0001_tier_nsg_inbound_rules" {
}

variable "public_portal_int_0001_tier_nsg_outbound_rules" {
}

variable "public_portal_int_0001_tier_delegation" {
  default = null
}

variable "public_portal_app_0002_tier_cidr" {}

variable "public_portal_app_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "public_portal_app_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "public_portal_app_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "public_portal_app_0002_tier_delegation" {
  default = null
}

variable "public_portal_db_0001_tier_cidr" {}

variable "public_portal_db_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "public_portal_db_0001_tier_nsg_inbound_rules" {
  default = []
}

variable "public_portal_db_0001_tier_nsg_outbound_rules" {
  default = []
}

variable "public_portal_db_0001_tier_delegation" {
  default = null
}

variable "public_portal_db_0002_tier_cidr" {}

variable "public_portal_db_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}

variable "public_portal_db_0002_tier_nsg_inbound_rules" {
  default = []
}

variable "public_portal_db_0002_tier_nsg_outbound_rules" {
  default = []
}

variable "public_portal_db_0002_tier_delegation" {
  default = null
}
