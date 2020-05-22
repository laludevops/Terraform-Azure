locals {
    diag_object = {
      for k,v in var.databases :
      "${k}" => {
        resource_id = [azurerm_sql_database.sql_database[k].id]
        log         = var.diag_object.log
        metric      = var.diag_object.metric
      }
      if lookup(azurerm_sql_database.sql_database, k, {}) != {}
    }

}

# module "diagnostics_sqldb" {
#   source  = "../az-terraform-diagnostic-settings-datasrc"

#   log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
#   diag_object                     = local.diag_object
#   naming_convention_info          = var.naming_convention_info
#   dependencies                    = [azurerm_sql_database.sql_database]
#   resource_type                   = "dbdiag" 
#   tags                            = var.tags
# }


# locals {
#     sqlserver_diag_object = {
#       "${var.naming_convention_info.name}" = {
#         resource_id = [azurerm_sql_server.sqlserver.id]
#         log         = []
#         metric      = var.diag_object.metric
#       }
#     }
# }

module "diagnostics_sqldb" {
  source  = "../az-terraform-diagnostic-settings-datasrc"

  log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
  diag_object                     = local.diag_object
  naming_convention_info          = var.naming_convention_info
  dependencies                    = [azurerm_sql_database.sql_database]
  resource_type                   = "dbsdiag" 
  tags                            = var.tags
}