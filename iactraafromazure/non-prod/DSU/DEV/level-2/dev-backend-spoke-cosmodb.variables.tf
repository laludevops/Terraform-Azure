variable "dev_backend_cosmosdb_name" { 
     type = string
}

variable "dev_backend_cosmosdb_resource_group_name" { 
     type = string
}

variable "dev_backend_cosmosdb_location" {
     type = string
     default = "southeastasia"
}

variable "dev_backend_cosmosdb_tags" {
    type =  map(string)
    description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dev_backend_cosmosdb_offer_type" {
    type = string
}

variable "dev_backend_cosmosdb_kind" {
    type = string
    default = "GlobalDocumentDB"
}

variable "dev_backend_cosmosdb_consistency_policy" {
    type = object({
        consistency_level       = string
        max_interval_in_seconds = number
        max_staleness_prefix    = number
    })
}

variable "dev_backend_cosmosdb_geo_location" {
    type = list(object({
        prefix              = string
        location            = string
        failover_priority   = number
    }))
}

variable "dev_backend_cosmosdb_ip_range_filter" {
    type = string
    default = null
}

variable "dev_backend_cosmosdb_enable_automatic_failover" {
    type = bool
    default = null
}

variable "dev_backend_cosmosdb_capabilities" {
    type = string
    default = null
} 

variable "dev_backend_cosmosdb_is_virtual_network_filter_enabled" {
    type = bool
    default = null
} 

variable "dev_backend_cosmosdb_enable_multiple_write_locations" {
    type = bool
    default = null
}


variable "dev_backend_cosmosdb_virtual_network_rule" {
  type = list(object({
        id = string
  }))
  default = null
}

variable "dev_backend_cosmosdb_diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    })
}
 