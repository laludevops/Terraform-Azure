locals {
# For naming convention purpose
  dev_backend_cosmosdb_naming_convention_info = {
    name          = var.dev_backend_cosmosdb_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.backend_zone_name
    tier          = var.cache_tier_name
  }
}
module "dev_backend_cosmosdb_cosmosdb" {
    source = "../../../../modules/az-terraform-db-cosmosdb"
  
    naming_convention_info = local.dev_backend_cosmosdb_naming_convention_info

    tags = var.dev_backend_cosmosdb_tags

    location = var.dev_backend_cosmosdb_location
    resource_group_name = var.dev_backend_cosmosdb_resource_group_name 
    offer_type          = var.dev_backend_cosmosdb_offer_type
    kind                = var.dev_backend_cosmosdb_kind
    ip_range_filter     = var.dev_backend_cosmosdb_ip_range_filter
    enable_automatic_failover = var.dev_backend_cosmosdb_enable_automatic_failover
    capabilities = var.dev_backend_cosmosdb_capabilities
    is_virtual_network_filter_enabled = var.dev_backend_cosmosdb_is_virtual_network_filter_enabled
    enable_multiple_write_locations = var.dev_backend_cosmosdb_enable_multiple_write_locations
    consistency_policy = var.dev_backend_cosmosdb_consistency_policy
    geo_location = var.dev_backend_cosmosdb_geo_location
    virtual_network_rule = var.dev_backend_cosmosdb_virtual_network_rule
    diag_object = var.dev_backend_cosmosdb_diag_object
}
