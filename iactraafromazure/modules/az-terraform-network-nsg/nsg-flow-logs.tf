
resource "azurerm_network_watcher_flow_log" "nw_flow" {

  for_each             = var.netwatcher == null  ? {} : azurerm_network_security_group.nsg_obj 
  enabled              = var.netwatcher != null ? true : false
  network_watcher_name = var.netwatcher.network_watcher_name
  resource_group_name  = var.netwatcher.resource_group_name

  network_security_group_id = each.value.id
  storage_account_id        = var.netwatcher.storage_account_id

  retention_policy {
    enabled = var.netwatcher.retention_period_days > 0 ? true : false
    days    = var.netwatcher.retention_period_days
  }
  depends_on = [azurerm_network_security_group.nsg_obj]
  traffic_analytics {
    enabled               = var.netwatcher.law != null ? true : false
    workspace_id          = var.netwatcher.law.workspace_id
    workspace_region      = var.location //"Southeast Asia"
    workspace_resource_id = var.netwatcher.law.id
  }
}
