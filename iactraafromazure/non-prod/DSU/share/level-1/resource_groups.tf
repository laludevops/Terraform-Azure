module "level_1_resource_groups" {
  source = "../../../../modules/az-terraform-resource-group"
  resource_groups = {
    flow_logs = {
      name     = var.network_watcher_storage_resource_group_name
      location = var.location
      tags     = {}
    }
    kv = {
      name     = "rg_dsu_keyvault"
      location = var.location
      tags     = {}
    }
    rsv = {
      name     = "rg_dsu_backup"
      location = var.location
      tags     = {}
    }
    public_portal_nsg = {
      name     = var.public_portal_route_table_resource_group_name
      location = var.location
      tags     = {}
    }
    backend_nsg = {
      name     = var.backend_route_table_resource_group_name
      location = var.location
      tags     = {}
    }
    internal_portal_nsg = {
      name     = var.internal_portal_route_table_resource_group_name
      location = var.location
      tags     = {}
    }
  }
}
