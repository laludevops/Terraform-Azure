variable "loga_workspace_name" { }
variable "law_retention_days" {    
    default = 365
}

variable "loga_resource_group_name" { }

variable "resource_group_name" { }

variable "location" {
    default  = "southeastasia"
}

variable "devops_zone_name" {
    default  = "dz"
}

variable "na_tier_name" {
    default     = "na"
}

variable "env" {
    default = "ort"
}

variable "project_code" {
    default = "mock"
}

variable "agency_code" {    
    default = "iras"
}

variable "storage_account_kind" { }

variable "storage_account_sku" { }

variable "storage_account_tier" { }