locals {
    diag_object = var.diag_object == null ? null : {
      "${var.naming_convention_info.name}" = {
        resource_id = [azurerm_storage_account.sst_obj.id]
        log         = var.diag_object.log
        metric      = var.diag_object.metric
      }
    }
    # cnt_diag_object = {
    #   for key, value in var.containers :
    #   "${key}" => {
    #     resource_id = [azurerm_storage_container.ss_cnt_obj[key].id]
    #     log         = var.diag_object.log
    #     metric      = var.diag_object.metric
    #   }
    # }
}

module "diagnostics" {
  source  = "../az-terraform-diagnostic-settings"

  log_analytics_workspace_id      = var.diag_object == null || var.diag_object == {} ? "" : var.diag_object.log_analytics_workspace_id
  diag_object                     = local.diag_object
  naming_convention_info          = var.naming_convention_info
  dependencies                    = [azurerm_storage_account.sst_obj]
  resource_type                   = "sstdiag" 
  tags                            = var.tags
}


# module "diagnostics_container" {
#   source  = "../az-terraform-diagnostic-settings-datasrc"

#   log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
#   diag_object                     = local.cnt_diag_object
#   naming_convention_info          = var.naming_convention_info
#   dependencies                    = [azurerm_storage_account.sst_obj]
#   resource_type                   = "cntdiag" 
#   tags                            = var.tags
# }