# resource "azurerm_virtual_machine_extension" "log_extension" {
#   count              = var.diag_object != null ? var.instance_count : 0
#   name               = element(module.vm_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
#   virtual_machine_id = azurerm_virtual_machine.vm_obj[count.index].id
#   location           = var.location

#   resource_group_name        = var.resource_group_name
#   publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
#   type                       = "MicrosoftMonitoringAgent"
#   type_handler_version       = "1.0"
#   auto_upgrade_minor_version = true

#   virtual_machine_name = local.vm_nameazurerm_virtual_machine.vm_obj[count.index].name

#   settings = <<SETTINGS
#   {
#     "workspaceId": "${var.log_analytics_workspace_guid}"
#   }
# SETTINGS

#   protected_settings = <<SETTINGS
#   {
#     "workspaceKey": "${var.log_analytics_workspace_key}"
#   }
# SETTINGS
# }
