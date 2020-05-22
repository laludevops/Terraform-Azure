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


output "dsu_public_portal_spoke_route_table_info" {
  value = {
    id                  = module.dsu_public_portal_spoke_route_table.rt_output.id
    name                = module.dsu_public_portal_spoke_route_table.rt_output.name
    resource_group_name = module.dsu_public_portal_spoke_route_table.rt_output.resource_group_name
  }
}


output "dsu_backend_spoke_route_table_info" {
  value = {
    id                  = module.dsu_backend_spoke_route_table.rt_output.id
    name                = module.dsu_backend_spoke_route_table.rt_output.name
    resource_group_name = module.dsu_backend_spoke_route_table.rt_output.resource_group_name
  }
}


output "dsu_internal_portal_spoke_route_table_info" {
  value = {
    id                  = module.dsu_internal_portal_spoke_route_table.rt_output.id
    name                = module.dsu_internal_portal_spoke_route_table.rt_output.name
    resource_group_name = module.dsu_internal_portal_spoke_route_table.rt_output.resource_group_name
  }
}

