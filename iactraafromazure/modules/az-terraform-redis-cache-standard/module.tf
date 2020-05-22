resource "azurerm_redis_cache" "redis_standard" {
  name                = module.redis_cache_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.redis_cache.capacity
  family              = var.redis_cache.family
  sku_name            = var.redis_cache.sku_name
  enable_non_ssl_port = var.redis_cache.enable_non_ssl_port
  minimum_tls_version = var.redis_cache.minimum_tls_version
  tags                = module.redis_cache_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0

  redis_configuration {
    enable_authentication             = var.standard_redis_cache.enable_authentication
    maxmemory_reserved                = var.standard_redis_cache.maxmemory_reserved
    maxmemory_delta                   = var.standard_redis_cache.maxmemory_delta
    maxmemory_policy                  = var.standard_redis_cache.maxmemory_policy
    maxfragmentationmemory_reserved   = var.standard_redis_cache.maxfragmentationmemory_reserved
  }
}

resource "azurerm_redis_firewall_rule" "redis_firewall" {
  name                = module.firewall_resource_name.naming_convention_output[var.firewall_name].names.0
  redis_cache_name    = azurerm_redis_cache.redis_standard.name
  resource_group_name = var.resource_group_name
  start_ip            = var.start_ip
  end_ip              = var.end_ip
}