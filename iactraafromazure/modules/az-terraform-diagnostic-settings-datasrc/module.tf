
locals {
  # step 1
  # prepare the input data for each resource_id element in the array for each map of diag_object
  # clean up the log data 
  diag_object_arr = flatten([for key, value in var.diag_object : [
    for cntr in range(length(value.resource_id)) : {
      key                    = key
      index                  = cntr
      resource_id            = value.resource_id[cntr]
      bln_use_datasrc_metric = length(value.metric) > 0 ? (lower(value.metric[0][0]) == "allmetrics") : false
      bln_use_datasrc_log    = length(value.log) > 0 ? (lower(value.log[0][0]) == "alllogs") : false
      log                    = lookup(value, "log", []) == null ? [] : lookup(value, "log")
      metric                 = value.metric
    }
  ]])


  # step 2
  #create a map of above object as for_each support only map /set 
  diag_object_map = { for s in local.diag_object_arr : format("%s_%d", s.key, s.index) => s }

  # step 4 ( previous steps in the dia_data_source.tf)
  # Prepare the diag_object for creation diag settings
  diag_object = {
    for key, value in local.diag_object_map :
    "${key}" => {
      index                  = value.index
      key                    = value.key
      resource_id            = value.resource_id
      bln_use_datasrc_log    = value.bln_use_datasrc_log
      bln_use_datasrc_metric = value.bln_use_datasrc_metric

      #if bln_use_datasrc_log is true, get the data from the data source or use the input variable
      datasrc_log = value.bln_use_datasrc_log ? [
        for lg in lookup(lookup(local.datasrc_op, key, {}), "logs", []) :
      [lg, value.log[0][1], value.log[0][2], value.log[0][3]]] : value.log

      # #if bln_use_datasrc_metric is true, get the data from the data source or use the input variable
      # datasrc_metric = value.bln_use_datasrc_metric  ? [
      #     for lg in lookup(lookup(local.datasrc_op, key, {}), "metrics", []) :
      #         [lg, value.metric[0][1], value.metric[0][2], value.metric[0][3] ]] : []  

      log    = value.log
      metric = value.metric
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  lifecycle {
    ignore_changes = [log, metric]
  }
  for_each                   = local.diag_object
  name                       = module.diagnostic_name.naming_convention_output[each.value.key].names[each.value.index]
  target_resource_id         = each.value.resource_id
  depends_on                 = [data.azurerm_monitor_diagnostic_categories.diagnostics_data]
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = each.value.bln_use_datasrc_log ? each.value.datasrc_log : each.value.log
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

