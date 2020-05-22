locals {
    diag_object = {
      "${var.naming_convention_info.name}" = {
        resource_id = [azurerm_api_management.api_management.id]
        log         = var.diag_object.log
        metric      = var.diag_object.metric
      }
    }
}

module "diagnostics" {
  source  = "../az-terraform-diagnostic-settings-datasrc"

  log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
  diag_object                     = local.diag_object
  naming_convention_info          = var.naming_convention_info
  dependencies                    = [azurerm_api_management.api_management]
  resource_type                   = "apimdia" 
  tags                            = var.tags
}