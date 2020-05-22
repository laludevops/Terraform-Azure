# output "loga_output" {
#   value = {
#     name         = module.common_log_analytics_workspace.loga_output.name
#     id           = module.common_log_analytics_workspace.loga_output.id
#     workspace_id = module.common_log_analytics_workspace.loga_output.workspace_id
#   }
# }

output "storage_account_nw_logs_info" {
  value = {
    id   = module.storage_account_network_watcher_logs.sst_output.id
    name = module.storage_account_network_watcher_logs.sst_output.name
  }
}

# output "azure_automation_account_id" {
#   value = {
#     id   = module.azure_automation_account.azau_output.id
#     name = module.azure_automation_account.azau_output.name
#   }
# }

output "azure_backup_info" {
  value = {
    id   = module.azure_backup.rsv_output.id
    name = module.azure_backup.rsv_output.name
  }
}

output "common_azure_key_vault_info" {
  value = {
    id   = module.common_azure_key_vault.akv_output.id
    name = module.common_azure_key_vault.akv_output.name
    uri  = module.common_azure_key_vault.akv_output.vault_uri
  }
}


