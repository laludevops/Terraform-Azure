module "ort_level_1_resource_groups" {
  source = "../../../modules/az-terraform-resource-group"
  resource_groups = {
    flow_logs = {
      name                   = var.network_watcher_storage_resource_group_name
      location               = var.location
      naming_convention_info = local.common_naming_convention_info
      tags                   = local.common_services_tags
    }
    kv = {
      name                   = var.kv_resource_group_name
      location               = var.location
      naming_convention_info = local.common_naming_convention_info
      tags                   = local.common_services_tags
    }
    rsv = {
      name                   = var.azure_backup_resource_group_name
      location               = var.location
      naming_convention_info = local.common_naming_convention_info
      tags                   = local.common_services_tags
    }
    ez_ingress_egress = {
      name                   = var.internet_ingress_egress_nsg_resource_group_name
      location               = var.location
      naming_convention_info = local.internet_ingress_egress_naming_convention_info
      tags                   = local.internet_ingress_egress_tags
    }
    iz_ingress_egress = {
      name                   = var.intranet_ingress_egress_nsg_resource_group_name
      location               = var.location
      naming_convention_info = local.intranet_ingress_egress_naming_convention_info
      tags                   = local.intranet_ingress_egress_tags
    }
    public = {
      name                   = var.public_portal_nsg_resource_group_name
      location               = var.location
      naming_convention_info = local.public_portal_naming_convention_info
      tags                   = local.public_portal_tags
    }
    transit_hub = {
      name                   = var.transit_hub_nsg_resource_group_name
      location               = var.location
      naming_convention_info = local.transit_hub_naming_convention_info
      tags                   = local.transit_hub_tags
    }
  }
}
