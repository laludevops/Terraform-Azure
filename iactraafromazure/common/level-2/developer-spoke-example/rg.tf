module "cmn_level_2_resource_groups" {
  source = "../../../modules/az-terraform-resource-group"
  resource_groups = {
    cmn_developer_spoke_vm_resource_group_name = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.developer_spoke_naming_convention_info
      tags                   = local.landing_zone_tags
    }    
  }
}
