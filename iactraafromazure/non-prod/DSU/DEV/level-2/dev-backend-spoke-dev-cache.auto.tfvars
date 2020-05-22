dev_backend_redis_cache_name = "redis"

dev_backend_redis_cache_resource_group_name = "rg-alex-iac"

dev_backend_redis_cache_location = "southeastasia"

dev_backend_redis_cache_tags = {
    custom_tag = "Custom tag as needed"
}

dev_backend_redis_cache_redis_cache = {
    capacity            = 1
    family              = "P" 
    sku_name            = "Premium" 
    enable_non_ssl_port = false
    minimum_tls_version = "1.2"
}

dev_backend_redis_cache_standard_redis_cache = {
  enable_authentication           = true
  maxmemory_reserved              = 2
  maxmemory_delta                 = 2
  maxmemory_policy                = "volatile-lru"
  maxfragmentationmemory_reserved = 2
}

dev_backend_redis_cache_premium_redis_cache = {
    rdb_storage_connection_string   = ""
    rdb_backup_max_snapshot_count   = 1
    rdb_backup_frequency            = 15
    rdb_backup_enabled              = false
    zone                            = ["1"]
    subnet_id                       = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-alex-iac/providers/Microsoft.Network/virtualNetworks/Alex_vnet/subnets/redis_cache_subnet"
    shard_count                     = 1
    private_static_ip_address       = "10.20.1.200"
}
dev_backend_redis_cache_firewall_name   = "redisfw"
dev_backend_redis_cache_start_ip        = "1.0.0.0"
dev_backend_redis_cache_end_ip          = "1.1.0.0"

dev_backend_redis_cache_diag_object = {
  log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-alex-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-alex-001"
  log = []
  metric = [["AllMetrics", true, true, 80], ]
}

dev_backend_redis_cache_patch_schedule = {
  day_of_week    = "Monday"
  start_hour_utc = 1
}