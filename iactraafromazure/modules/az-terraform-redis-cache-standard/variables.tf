variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
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

variable "redis_cache" {
    description = "(Required) Specify the naming convention information to the resource."
    type =  object({      
        capacity            = number
        family              = string
        sku_name            = string
        enable_non_ssl_port = bool 
        minimum_tls_version = string
    })
}

variable "firewall_name" {
  description = "(Required) Specify the name for firewall"
  type        = string
}

variable "start_ip" {
  description = "start ip address range for firewall"
  type        = string
}

variable "end_ip" {
  description = "End ip address range for firewall"
  type        = string
}

variable "standard_redis_cache" {
    description = "(Required) values required for standard redis cache"
    type =  object({      
      enable_authentication           = bool
      maxmemory_reserved              = number
      maxmemory_delta                 = number
      maxmemory_policy                = string
      maxfragmentationmemory_reserved = number
    })
}




  
  
           
             