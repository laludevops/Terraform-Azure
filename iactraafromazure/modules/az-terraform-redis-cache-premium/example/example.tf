locals {
# For naming convention purpose
  naming_convention_info = {
    name          = "redis"
    agency_code   = "iras"
    project_code  = "irasgcc" 
    env           = "dev" 
    zone          = "z1"
    tier          = "web"
  }

  resource_group_name = "rg-alex-iac"
  location            = "southeastasia"
}

## retriving subnet to assign redis cache to
data "azurerm_subnet" "subnet_sample" {
  name                 = "redis_cache_subnet"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

## data used to pull id of log analyytics workspace
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name 
}


module "redis_cache" {
    source = "../"

    resource_group_name = local.resource_group_name
    location            = local.location

    naming_convention_info  = local.naming_convention_info

## tags to be used with naming convention, anything added here will be added to postgres sql tag
    tags = {
        custom_tag = "Custom tag as needed"
    }

## values required for redis cache
    redis_cache = {
        capacity            = 1
        family              = "P" 
        sku_name            = "Premium" 
        enable_non_ssl_port = false
        minimum_tls_version = "1.2"
    }

## configuration settings for redis_configuration
    standard_redis_cache = {
      enable_authentication           = true
      maxmemory_reserved              = 2
      maxmemory_delta                 = 2
      maxmemory_policy                = "volatile-lru"
      maxfragmentationmemory_reserved = 2
    }

## addtional value used if premium is used
    premium_redis_cache = {
        ## Connection String to the Storage Account, if left blank it will be ignored
        rdb_storage_connection_string   = "DefaultEndpointsProtocol=https;AccountName=redissstorageaccount;AccountKey=RYEjLB/2xw7GDYr0Ti5eXQuTg3PlqK2U0Fba5SJYHdvHel5WgyerpUGkLJHqIr/gwI7EH/fvQ2yBj/PnR4PIKQ==;EndpointSuffix=core.windows.net"
        rdb_backup_max_snapshot_count   = 1
        rdb_backup_frequency            = 15
        rdb_backup_enabled              = false
        ## Availability zone to be assigned (optional) if not required put value as null
        zone                            = ["1"]
        ## Subnet id which redis cache will be deployed, 
        ## subnet assigned should only contain Azure Cache for Redis instances without any other type of resources. (optional) if not required put value as null
        subnet_id                       = data.azurerm_subnet.subnet_sample.id
        ## Number of shard to be created (optional) if not required put value as null
        shard_count                     = 1
        ## Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network (optional) if not required put value as null
        private_static_ip_address       = "10.20.1.200"
    }

## Custom name to be given for redis cache firewall
    firewall_name   = "redisfw"
## start and end ip for firewall
    start_ip        = "1.0.0.0"
    end_ip          = "1.1.0.0"

  diag_object = {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
    log = []
    metric = [["AllMetrics", true, true, 80], ]
  }
## (optional) if not required put value as null
  patch_schedule = {
    day_of_week    = "Monday"
    start_hour_utc = 1
  }

}

output "redis_premium" {
  description = "List of redis_standard"
  value = module.redis_cache.redis_premium
}

output "diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.redis_cache.diagnostic_log
}

output "redis_firewall" {
  description = "List of redis_firewall"
  value = module.redis_cache.redis_firewall
}
