variable "devops_spoke_vnet_name" {}
variable "devops_spoke_vnet_resource_group_name" {}

variable "devops_tmt_0001_tier_cidr" {}
variable "devops_tmt_0001_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "devops_tmt_0001_tier_nsg_inbound_rules" {}
variable "devops_tmt_0001_tier_nsg_outbound_rules" {}
variable "devops_tmt_0001_tier_delegation" {
  default = null
}

variable "devops_tmt_0002_tier_cidr" {}
variable "devops_tmt_0002_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "devops_tmt_0002_tier_nsg_inbound_rules" {}
variable "devops_tmt_0002_tier_nsg_outbound_rules" {}
variable "devops_tmt_0002_tier_delegation" {
  default = null
}

variable "devops_app_tier_cidr" {}
variable "devops_app_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "devops_app_tier_nsg_inbound_rules" {}
variable "devops_app_tier_nsg_outbound_rules" {}
variable "devops_app_tier_delegation" {
  default = null
}

variable "devops_aks_tier_cidr" {}
variable "devops_aks_tier_service_endpoints" {
  type    = list(string)
  default = null
}
variable "devops_aks_tier_nsg_inbound_rules" {}
variable "devops_aks_tier_nsg_outbound_rules" {}
variable "devops_aks_tier_delegation" {
  default = null
}

variable "devops_db_tier_cidr" {}
variable "devops_db_tier_service_endpoints" {
  type = list(string)
}
variable "devops_db_tier_nsg_inbound_rules" {
  default = []
}
variable "devops_db_tier_nsg_outbound_rules" {
  default = []
}
variable "devops_db_tier_delegation" {
  default = null
}

# variable "devops_rsv_tier_cidr" {}

# variable "devops_rsv_tier_service_endpoints" {
#     type = list(string)
#     default = null
# }

# variable "devops_rsv_tier_nsg_inbound_rules" {
#     default = []
# }

# variable "devops_rsv_tier_nsg_outbound_rules" {
#     default = []
# }

# variable "devops_rsv_tier_delegation" {
#     default = null
# }

variable "devops_spoke_route_table_resource_group_name" {}

variable "devops_spoke_nsg_resource_group_name" {}
