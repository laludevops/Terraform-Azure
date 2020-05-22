locals {
  mz_db_zone_naming_convention_info = merge(var.naming_convention_info, { "zone" = var.mz_zone_name, "tier" = var.mz_db_tier_name })
}

module "wsus_server_sql" {
  source              = "../../modules/az-terraform-azure-sql"
  resource_group_name = var.resource_group_name
  location            = var.location
  databases = {
    database_1 = {
      name                             = "Management_Update_Configuration"
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
  naming_convention_info = merge(local.mz_db_zone_naming_convention_info, { name = var.wsus_server_sql_name })
  tags                   = var.tags
}
