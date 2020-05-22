module "cmn_level_2_resource_groups" {
  source = "../../modules/az-terraform-resource-group"
  resource_groups = {
    developer_vm_resource_group_name = {
      name                   = var.developer_vm_resource_group_name
      location               = var.location
      naming_convention_info = local.developer_spoke_naming_convention_info
      tags                   = local.developer_spoke_tags
    } 
    devops_acr_resource_group_name = {
      name                   = var.devops_acr_resource_group_name
      location               = var.location
      naming_convention_info = local.devops_zone_naming_convention_info
      tags                   = local.common_services_tags
    }
  }
}
