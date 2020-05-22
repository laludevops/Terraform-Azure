resource "azurerm_cosmosdb_account" "account" {
    name                              = module.cosmosdb_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
    resource_group_name               = var.resource_group_name
    location                          = var.location
    tags                              = module.cosmosdb_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0
    offer_type                        = var.offer_type
    kind                              = var.kind

    consistency_policy {    
        consistency_level       = var.consistency_policy.consistency_level
        max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
        max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
    }

    dynamic "geo_location" {
        for_each = var.geo_location != null ? var.geo_location : []
        content {
            location          = geo_location.value.location
            failover_priority = geo_location.value.failover_priority
        }
    }

    ip_range_filter                   = var.ip_range_filter
    enable_automatic_failover         = var.enable_automatic_failover




    dynamic "capabilities" {
        for_each = var.capabilities != null ? [1] : []

        content {
            name = var.capabilities
        }
    }

    is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled

    dynamic "virtual_network_rule" {
        for_each = var.virtual_network_rule != null ? var.virtual_network_rule : []
        content {
            id = virtual_network_rule.value.id
        }
    }

    enable_multiple_write_locations   = var.enable_multiple_write_locations
}
