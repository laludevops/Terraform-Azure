# get the diagnostics categories from azure for elements that has the log ["AllLogs", true, true, <some-no>]
locals {
    datasrc_op = data.azurerm_monitor_diagnostic_categories.diagnostics_data
}

data "azurerm_monitor_diagnostic_categories" "diagnostics_data" {
   for_each    = local.diag_object_map
   resource_id = each.value.resource_id
   depends_on = [var.dependencies]
}