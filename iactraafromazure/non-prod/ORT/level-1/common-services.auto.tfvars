loga_workspace_name      = "loga-irasgcc-dev-z1-web-alex-001"
loga_resource_group_name = "rg-alex-iac"

network_watcher_name           = "NetworkWatcher_southeastasia"
netwatcher_resource_group_name = "NetworkWatcherRG"

kv_resource_group_name                      = "rg_ort_keyvault"
network_watcher_storage_resource_group_name = "rg_ort_storageaccount_networkwatcher"
automation_account_resource_group_name      = "rg_ort_backup"
azure_backup_resource_group_name            = "rg_ort_backup"

common_nsg_inbound_rule_deny_all = null
common_nsg_outbound_rule_deny_all = [
  {
    priority                                   = "4096"
    access                                     = "Deny"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_address_prefix                      = "VirtualNetwork"
    destination_address_prefix                 = "Internet"
    source_application_security_group_ids      = null
    destination_application_security_group_ids = null
  }
]
