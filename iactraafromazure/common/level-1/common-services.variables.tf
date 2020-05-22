variable "loga_workspace_name" {}
variable "loga_resource_group_name" {}
variable "azure_backup_resource_group_name" {}
variable "automation_account_resource_group_name" {}
variable "network_watcher_name" {}
variable "netwatcher_resource_group_name" {}
variable "kv_resource_group_name" {}
variable "network_watcher_storage_resource_group_name" {}

variable "common_services_zone_name" {
  default = "dz"
}

variable "location" {
  default = "southeastasia"
}

#region Zones

variable "internet_zone_name" {
  default = "ez"
}

variable "intranet_zone_name" {
  default = "iz"
}

variable "management_zone_name" {
  default = "mz"
}

variable "devops_zone_name" {
  default = "dz"
}

#end region zones

#region Tiers

variable "web_tier_name" {
  default = "web"
}

variable "app_tier_name" {
  default = "app"
}

variable "db_tier_name" {
  default = "db"
}

variable "integration_tier_name" {
  default = "it"
}

variable "management_tier_name" {
  default = "tmt"
}

variable "na_tier_name" {
  default = "na"
}

variable "hsm_tier_name" {
  default = "hsm"
}

variable "rsv_tier_name" {
  default = "rsv"
}

variable "ingress_tier_name" {
  default = "ig"
}

variable "egress_tier_name" {
  default = "eg"
}

variable "gut_tier_name" {
  default = "gut"
}

#end region Tiers

#region environment

variable "env" {
  default = "cmn"
}
#end region environment


#region Project Code
variable "project_code" {
  default = "irin"
}
#end region Project Code


#region Agency Code
variable "agency_code" {
  default = "iras"
}
#end region Agency Code

variable "law_retention_days" {
  default = 365
}

variable "netwatcher_retention_days" {
  default = 365
}


variable "common_nsg_inbound_rule_deny_all" {
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

variable "common_nsg_outbound_rule_deny_all" {
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
