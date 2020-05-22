locals {
  dz_db_zone_naming_convention_info = merge(var.naming_convention_info, { "zone" = var.dz_name, "tier" = var.dz_db_tier_name })
}

module "tosca_server_sql" {
  source              = "../../modules/az-terraform-azure-sql"
  resource_group_name = var.resource_group_name
  location            = var.location
  databases = {
    database_1 = {
      name                             = "AzureDevOps_Tosca_Configuration"
      collation                        = "SQL_LATIN1_GENERAL_CP1_CI_AS"
      edition                          = "Standard"
      requested_service_objective_name = "S4"
      max_size_bytes                   = "268435456000"
    }
  }
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, 80], ]
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  naming_convention_info = merge(local.dz_db_zone_naming_convention_info, { name = var.tosca_server_sql_name })
  tags                   = var.tags
}

module "fortify_ssc_sql" {
  source              = "../../modules/az-terraform-azure-sql"
  resource_group_name = var.resource_group_name
  location            = var.location
  databases = {
    database_1 = {
      name                             = "AzureDevOps_Fortify_Configuration"
      collation                        = "SQL_LATIN1_GENERAL_CP1_CI_AS"
      edition                          = "Standard"
      requested_service_objective_name = "S4"
      max_size_bytes                   = "268435456000"
    }
  }
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, 80], ]
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  naming_convention_info = merge(local.dz_db_zone_naming_convention_info, { name = var.fortify_ssc_sql_name })
  tags                   = var.tags
}

module "xxx_postgres_sql" {
  source              = "../../modules/az-terraform-postgres-sql"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name              = "GP_Gen5_2"
  storage_mb            = 5120
  backup_retention_days = 7
  geo_redundant_backup  = "Disabled"
  server_version        = "9.5"
  ssl_enforcement       = "Enabled"

  postgresql_configurations = {
    config_1 = {
      config_name  = "backslash_quote"
      config_value = "on"
    }
  }

  database = {
    db_1 = {
      db_names     = "database_1"
      db_charset   = "UTF8"
      db_collation = "English_United States.1252"
    }
  }

  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = [["AllLogs", true, true, 80], ]
    metric                     = [["AllMetrics", true, true, 80], ]
  }

  naming_convention_info = merge(local.dz_db_zone_naming_convention_info, { name = var.postgres_sql_name })
  tags                   = var.tags
}
