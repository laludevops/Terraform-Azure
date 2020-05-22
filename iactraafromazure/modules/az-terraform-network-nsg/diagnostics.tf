locals {
    diag_object = {
      for key, value in var.nsg_info : 
        "${key}" => {
          resource_id = [azurerm_network_security_group.nsg_obj[key].id]
          log         = var.diag_object.log
          metric      = var.diag_object.metric
        }
      if lookup(azurerm_network_security_group.nsg_obj, key, {}) != {}
    }
}

module "diagnostics_nsg" {
  source  = "../az-terraform-diagnostic-settings-datasrc"

  log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
  diag_object                     = local.diag_object
  dependencies                    = [azurerm_network_security_group.nsg_obj]
  naming_convention_info          = var.naming_convention_info
  resource_type                   = "nsgdiag" 
  tags                            = var.tags
}

output "diag_obj" {
  value = module.diagnostics_nsg.diag_object
}