variable "dev_intranet_redis_cache_name" {
    type = string
}

variable "dev_intranet_redis_cache_resource_group_name" {
    type = string
}

variable "dev_intranet_redis_cache_location" {
    type = string
}


variable "dev_intranet_redis_cache_diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    })
}

variable "dev_intranet_redis_cache_tags" {
  description = "(optional) User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "dev_intranet_redis_cache_redis_cache" {
    description = "(Required) Specify the naming convention information to the resource."
    type =  object({      
        capacity            = number
        family              = string
        sku_name            = string
        enable_non_ssl_port = bool 
        minimum_tls_version = string
    })
}

variable "dev_intranet_redis_cache_firewall_name" {
  description = "(Required) Specify the name for firewall"
  type        = string
}

variable "dev_intranet_redis_cache_start_ip" {
  description = "start ip address range for firewall"
  type        = string
}

variable "dev_intranet_redis_cache_end_ip" {
  description = "End ip address range for firewall"
  type        = string
}

variable "dev_intranet_redis_cache_standard_redis_cache" {
    description = "(Required) Specify the naming convention information to the resource."
    type =  object({      
      enable_authentication           = bool
      maxmemory_reserved              = number
      maxmemory_delta                 = number
      maxmemory_policy                = string
      maxfragmentationmemory_reserved = number
    })
}

variable "dev_intranet_redis_cache_premium_redis_cache" {
    description = "(Required) values required for premium redis cache"
    type =  object({      
      rdb_storage_connection_string = string
      rdb_backup_max_snapshot_count = number
      rdb_backup_frequency          = number
      rdb_backup_enabled            = bool
      subnet_id                     = string
      zone                          = list(string)
      private_static_ip_address     = string
      shard_count                   = number
    })
}

variable "dev_intranet_redis_cache_patch_schedule" {
    type = object(
         {
              day_of_week      = string
              start_hour_utc   = number
         }
    )
    default = null
}
  
  
           
             