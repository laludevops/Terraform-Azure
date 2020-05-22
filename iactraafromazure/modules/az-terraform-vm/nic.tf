locals {
  blncreatenic = var.nic_ids == null ? true : false
}

module "nic_obj" {
  source                 = "../az-terraform-network-nic"
  location               = var.location
  resource_group_name    = var.resource_group_name
  instance_count         = local.blncreatenic ? var.instance_count : 0
  subnet_id              = local.blncreatenic ? var.nic_info.subnet_id : ""
  nic_info               = local.blncreatenic ? var.nic_info.nics : null
  nsg_id                 = local.blncreatenic ? var.nic_info.nsg_id : ""
  diag_object            = var.diag_object
  naming_convention_info = var.naming_convention_info
  tags                   = var.tags
}
