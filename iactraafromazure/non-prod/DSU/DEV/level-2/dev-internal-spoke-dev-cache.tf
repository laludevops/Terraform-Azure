locals {
# For naming convention purpose
  dev_intranet_redis_cache_naming_convention_info = {
    name          = var.dev_intranet_redis_cache_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.intranet_zone_name
    tier          = var.cache_tier_name
  }
}

module "dev_intranet_redis_cache" {
    source = "../../../../modules/az-terraform-redis-cache-premium"

    resource_group_name = var.dev_intranet_redis_cache_resource_group_name
    location            = var.dev_intranet_redis_cache_location

    naming_convention_info  = local.dev_intranet_redis_cache_naming_convention_info
    tags                    = var.dev_intranet_redis_cache_tags
    premium_redis_cache     = var.dev_intranet_redis_cache_premium_redis_cache

    standard_redis_cache    = var.dev_intranet_redis_cache_standard_redis_cache
    redis_cache             = var.dev_intranet_redis_cache_redis_cache
    firewall_name           = var.dev_intranet_redis_cache_firewall_name
    start_ip                = var.dev_intranet_redis_cache_start_ip
    end_ip                  = var.dev_intranet_redis_cache_end_ip
    diag_object             = var.dev_intranet_redis_cache_diag_object
    patch_schedule          = var.dev_intranet_redis_cache_patch_schedule

}