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
        family              = "C" 
        sku_name            = "Standard" 
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

## the custom name to be given for redis cache firewall
    firewall_name   = "redisfw"
## start and end ip for firewall
    start_ip        = "1.0.0.0"
    end_ip          = "1.1.0.0"

  diag_object = {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
    log = []
    metric = [["AllMetrics", true, true, 80], ]
  }

}

output "redis_standard" {
  description = "List of redis_standard"
  value = module.redis_cache.redis_standard
}

output "diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.redis_cache.diagnostic_log
}

output "redis_firewall" {
  description = "List of redis_firewall"
  value = module.redis_cache.redis_firewall
}
