    dev_backend_azsql_resource_group_name   = "rg-alex-iac"
    dev_backend_azsql_location              = "southeastasia"
    dev_backend_azsql_vnet_rules = {}
    dev_backend_azsql_firewall_rules = {}
    dev_backend_azsql_databases = {
      database_1 = {
        name                             = "AzureDevOps_Configuration"
        collation                        = "SQL_LATIN1_GENERAL_CP1_CI_AS"
        edition                          = "Standard"
        requested_service_objective_name = "S4"
        max_size_bytes                   = "268435456000"
      }
    }
    dev_backend_azsql_diag_object          = { 
      log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-alex-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-alex-001"
        log  = [["AllLogs", true, true, 80], ]
         metric = [["AllMetrics", true, true, 80], ]
    }
    dev_backend_azsql_name    = "azsql"
    dev_backend_azsql_tags    = {
    custom_tag = "Custom tag as needed"
    }
