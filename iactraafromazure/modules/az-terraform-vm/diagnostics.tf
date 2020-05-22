locals {
    diag_object = var.diag_object == null ? {} : {
      "${var.naming_convention_info.name}" = {
          resource_id = [for key,value in azurerm_virtual_machine.vm_obj : value.id]
          log         = var.diag_object.log
          metric      = var.diag_object.metric
      }
    }
}
# not supported
# module "diagnostics" {
#   source  = "../az-terraform-diagnostic-settings"
#   log_analytics_workspace_id      = var.diag_object == null ? "" : var.diag_object.log_analytics_workspace_id
#   diag_object                     = local.diag_object
#   naming_convention_info          = var.naming_convention_info
#   dependencies                    = [azurerm_virtual_machine.vm_obj]
#   resource_type                   = "vmdiag" 
#   tags                            = var.tags
# }