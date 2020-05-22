resource "azurerm_redis_cache" "redis_premium" {
  name                      = module.redis_cache_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
  location                  = var.location
  resource_group_name       = var.resource_group_name
  capacity                  = var.redis_cache.capacity
  family                    = var.redis_cache.family
  sku_name                  = var.redis_cache.sku_name
  enable_non_ssl_port       = var.redis_cache.enable_non_ssl_port
  minimum_tls_version       = var.redis_cache.minimum_tls_version
  tags                      = module.redis_cache_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0
  zones                     = var.premium_redis_cache.zone
  subnet_id                 = var.premium_redis_cache.subnet_id
  shard_count               = var.premium_redis_cache.shard_count
  private_static_ip_address = var.premium_redis_cache.private_static_ip_address
  
  dynamic "patch_schedule"  {
    for_each = var.patch_schedule != null ? [1] : []

    content {
      day_of_week     = var.patch_schedule.day_of_week
      start_hour_utc  = var.patch_schedule.start_hour_utc
    }
  }

  redis_configuration {
    enable_authentication             = var.standard_redis_cache.enable_authentication
    maxmemory_reserved                = var.standard_redis_cache.maxmemory_reserved
    maxmemory_delta                   = var.standard_redis_cache.maxmemory_delta
    maxmemory_policy                  = var.standard_redis_cache.maxmemory_policy
    maxfragmentationmemory_reserved   = var.standard_redis_cache.maxfragmentationmemory_reserved
    rdb_storage_connection_string     = var.premium_redis_cache.rdb_backup_enabled != false ? var.premium_redis_cache.rdb_storage_connection_string : null
    rdb_backup_max_snapshot_count     = var.premium_redis_cache.rdb_backup_enabled != false ? var.premium_redis_cache.rdb_backup_max_snapshot_count : null
    rdb_backup_frequency              = var.premium_redis_cache.rdb_backup_enabled != false ? var.premium_redis_cache.rdb_backup_frequency : null
    rdb_backup_enabled                = var.premium_redis_cache.rdb_backup_enabled != false ? var.premium_redis_cache.rdb_backup_enabled : null
  }
}

resource "azurerm_redis_firewall_rule" "redis_firewall" {
  name                = module.firewall_resource_name.naming_convention_output[var.firewall_name].names.0
  redis_cache_name    = azurerm_redis_cache.redis_premium.name
  resource_group_name = var.resource_group_name
  start_ip            = var.start_ip
  end_ip              = var.end_ip
}