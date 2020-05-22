module "level_1_resource_groups" {
  source = "../../modules/az-terraform-resource-group"
  resource_groups = {
    "flow_logs" = {
      name                   = var.network_watcher_storage_resource_group_name
      location               = var.location
      tags                   = local.landing_zone_tags
      naming_convention_info = local.common_naming_convention_info
    }
    kv = {
      name                   = var.kv_resource_group_name
      location               = var.location
      tags                   = local.landing_zone_tags
      naming_convention_info = local.common_naming_convention_info
    }
    rsv = {
      name                   = var.azure_backup_resource_group_name
      location               = var.location
      naming_convention_info = local.common_naming_convention_info
      tags                   = local.landing_zone_tags
    }
    "developer_spoke_nsg" = {
      name                   = var.developer_spoke_nsg_resource_group_name
      location               = var.location
      tags                   = local.landing_zone_tags
      naming_convention_info = local.developer_naming_convention_info

    }
    "management_spoke_nsg" = {
      name                   = var.management_spoke_nsg_resource_group_name
      location               = var.location
      tags                   = local.landing_zone_tags
      naming_convention_info = local.management_zone_naming_convention_info
    }
    "devops_spoke_nsg" = {
      name     = var.devops_spoke_nsg_resource_group_name
      location = var.location
      naming_convention_info = merge(local.devops_naming_convention_info, {
        tier = var.na_tier_name
      })
      tags = local.landing_zone_tags
    }
    "common_mgmt_tmt_adds" = {
      name     = var.ad_ds_resource_group_name
      location = var.location
      naming_convention_info = merge(local.management_tmt_tier_naming_convention_info, {
        tier = var.management_tier_name
      })
      tags = local.landing_zone_tags
    }

  }
}
