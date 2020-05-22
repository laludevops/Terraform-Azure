locals {
    diag_object = {
      lb = {
        resource_id = [azurerm_lb.lb_obj.id]
        log         = var.diag_object.log
        metric      = var.diag_object.metric
      }
    }
}

module "diagnostics" {
  source  = "../az-terraform-diagnostic-settings"

  log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
  diag_object                     = local.diag_object
  naming_convention_info          = var.naming_convention_info
  dependencies                    = [azurerm_lb_rule.lb_rule]
  resource_type                   = "lbdiag" 
  tags                            = var.tags
}

