variable "tags" {
  description = "(optional) User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "(required) The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "(required) Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  type        = string
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "geo_redundant_backup" {
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  type        = string
  default     = "Disabled"
}

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "administrator_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
  default     = null
}

variable "server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, and 10.0. Changing this forces a new resource to be created."
  type        = string
  default     = "9.5"
}

variable "ssl_enforcement" {
  description = "Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled."
  type        = string
  default     = "Enabled"
}

variable "database" {
  description = "(Optional)Map of databases to be created"
  default     = null
  type = map(object({
    db_names     = string
    db_charset   = string
    db_collation = string
  }))
}

variable "firewall_rules" {
  description = "The list of maps, describing firewall rules. Valid map items: start_ip, end_ip."
  type        = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}

variable "vnet_rules" {
  description = "The list of maps, describing vnet rules. Valid map items: subnet_id."
  type        = map(object({
      subnet_id = string
    }))
  default = {}
}

variable "postgresql_configurations" {
  description = "A map with PostgreSQL configurations to enable."
  type        = map(object({
      config_name = string
      config_value = string
  }))
  default     = {}
}

variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object."
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
              agency_code   = string
              project_code  = string
              env           = string
              zone          = string 
              tier          = string
    })
}

# variable "firewall_name" {
#   description = "(Required) Specify the name for firewall"
#   type        = string
# }

# variable "vnet_name" {
#   description = "(Required) Specify the name for vnet"
#   type        = string
# }
