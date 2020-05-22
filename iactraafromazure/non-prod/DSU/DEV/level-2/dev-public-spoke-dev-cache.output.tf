output "dev_internet_redis_premium" {
  description = "List of redis_standard"
  value = module.dev_internet_redis_cache.redis_premium
}

output "dev_internet_redis_cache_diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.dev_internet_redis_cache.diagnostic_log
}

output "dev_internet_redis_firewall" {
  description = "List of redis_firewall"
  value = module.dev_internet_redis_cache.redis_firewall
}
