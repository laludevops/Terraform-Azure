locals {
    diag_object = {
      "${var.naming_convention_info.name}" = {
        resource_id = [azurerm_redis_cache.redis_premium.id]
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
  dependencies                    = [azurerm_redis_cache.redis_premium]
  resource_type                   = "rd" 
  tags                            = var.tags
}