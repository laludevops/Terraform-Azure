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

variable "resource_group_name" { 
     type = string
}

variable "location" {
     type = string
     default = "southeastasia"
}

variable "tags" {
    type =  map(string)
    description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "offer_type" {
    type = string
}

variable "kind" {
    type = string
    default = "GlobalDocumentDB"
}

variable "consistency_policy" {
    type = object({
        consistency_level       = string
        max_interval_in_seconds = number
        max_staleness_prefix    = number
    })
}

variable "geo_location" {
    type = list(object({
        prefix              = string
        location            = string
        failover_priority   = number
    }))
}

variable "ip_range_filter" {
    type = string
    default = null
}

variable "enable_automatic_failover" {
    type = bool
    default = null
}

variable "capabilities" {
    type = string
    default = null
} 

variable "is_virtual_network_filter_enabled" {
    type = bool
    default = null
} 

variable "enable_multiple_write_locations" {
    type = bool
    default = null
}


variable "virtual_network_rule" {
  type = list(object({
        id = string
  }))
  default = null
}

variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    })
}
 