module "ort_level_2_resource_groups" {
  source = "../../../modules/az-terraform-resource-group"
  resource_groups = {
    internet_palo_vm_resource_group_name = {
      name                   = var.internet_palo_vm_resource_group_name
      location               = var.location
      naming_convention_info = local.landing_zone_naming_convention
      tags                   = local.landing_zone_tags
    }
    internet_lb_resource_group_name = {
      name                   = var.internet_lb_resource_group_name
      location               = var.location
      naming_convention_info = local.landing_zone_naming_convention
      tags                   = local.landing_zone_tags
    }
    intranet_palo_vm_resource_group_name = {
      name                   = var.intranet_palo_vm_resource_group_name
      location               = var.location
      naming_convention_info = local.landing_zone_naming_convention
      tags                   = local.landing_zone_tags
    }
    intranet_lb_resource_group_name = {
      name                   = var.intranet_lb_resource_group_name
      location               = var.location
      naming_convention_info = local.landing_zone_naming_convention
      tags                   = local.landing_zone_tags
    }
    public_portal_forward_proxy_vm_resource_group_name = {
      name                   = var.public_portal_forward_proxy_vm_resource_group_name
      location               = var.location
      naming_convention_info = local.landing_zone_naming_convention
      tags                   = local.landing_zone_tags
    }
    transit_hub_palo_vm_resource_group_name = {
      name                   = var.transit_hub_palo_vm_resource_group_name
      location               = var.location
      naming_convention_info = local.landing_zone_naming_convention
      tags                   = local.landing_zone_tags
    }
  }
}
