# locals {
#      # step 1
#      # prepare the input data for each resource_id element in the array for each map of diag_object
#      # clean up the log data 
#     diag_object_arr = flatten([for key, value in var.diag_object : [
#         for cntr in range(length(value.resource_id)) : {
#             key = key
#             index = cntr
#             resource_id = value.resource_id[cntr]
#             log =  lookup(value, "log", []) == null ? [] : lookup(value, "log")
#             metric =  value.metric
#         } 
#     ]])
#     diag_object_map = { for s in local.diag_object_arr : format("%s_%d", s.key, s.index) => s }  
# }

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  lifecycle {
    ignore_changes = [log, metric]
  }
  for_each           = var.diag_object == null ? {} : var.diag_object
  name               = module.diagnostic_name.naming_convention_output[each.key].names.0
  target_resource_id = each.value.resource_id[0]
  depends_on         = [var.dependencies]
  # eventhub_name                    = lookup(var.diagnostics_map, "eh_name", null)
  # eventhub_authorization_rule_id   = lookup(var.diagnostics_map, "eh_id", null) != null ? "${var.diagnostics_map.eh_id}/authorizationrules/RootManageSharedAccessKey" : null

  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = lookup(each.value, "log_analytics_destination_type", null)

  #storage_account_id               = var.diagnostics_map.diags_sa

  dynamic "log" {
    for_each = each.value.log == null ? [] : each.value.log
    content {
      category = log.value[0]
      enabled  = log.value[1]
      retention_policy {
        enabled = log.value[2]
        days    = log.value[3]
      }
    }
  }

  dynamic "metric" {
    for_each = each.value.metric == null ? [] : each.value.metric
    content {
      category = metric.value[0]
      enabled  = metric.value[1]
      retention_policy {
        enabled = metric.value[2]
        days    = metric.value[3]
      }
    }
  }
}
