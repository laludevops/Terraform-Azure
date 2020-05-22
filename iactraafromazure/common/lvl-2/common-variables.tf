# common zone na tier variables

variable "location" {}
variable "loga_workspace_name" {}
variable "loga_resource_group_name" {}


variable "devops_acr_resource_group_name" {}
variable "devops_acr_sku" {}
variable "devops_acr_name" {}


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
