
    dev_backend_cosmosdb_tags = {
      "custom_tag" = "Custom tag as needed"
    }

    dev_backend_cosmosdb_name = "cosmosdb"
    dev_backend_cosmosdb_location = "southeastasia"
    dev_backend_cosmosdb_resource_group_name = "rg-alex-iac"
    dev_backend_cosmosdb_offer_type          = "Standard"
    dev_backend_cosmosdb_kind                = "GlobalDocumentDB"
    dev_backend_cosmosdb_ip_range_filter     = "1.1.1.1,2.2.2.2"
    dev_backend_cosmosdb_enable_automatic_failover = false
    dev_backend_cosmosdb_capabilities = null
    dev_backend_cosmosdb_is_virtual_network_filter_enabled = true
    dev_backend_cosmosdb_enable_multiple_write_locations = false
    dev_backend_cosmosdb_consistency_policy = {
            consistency_level       = "BoundedStaleness"
            max_interval_in_seconds = 10
            max_staleness_prefix    = 200
    }
    dev_backend_cosmosdb_geo_location = [
        {
            prefix            = null
            location          = "southeastasia"
            failover_priority = 0
        }
    ]

    dev_backend_cosmosdb_virtual_network_rule = [
        {
            id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-alex-iac/providers/Microsoft.Network/virtualNetworks/Alex_vnet/subnets/cosmosdb_subnet"
        }
    ]
    dev_backend_cosmosdb_diag_object = {
        log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-alex-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-alex-001"
        log = [["AllLogs", true, true, 80],]
        metric = [["AllMetrics", true, true, 80], ]
    }



