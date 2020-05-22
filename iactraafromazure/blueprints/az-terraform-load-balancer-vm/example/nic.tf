
module "nic_obj_untrust" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = "southeastasia"
  resource_group_name = local.resource_group_name
  instance_count   = local.vm_instance_count
  subnet_id           = data.azurerm_subnet.ingress_subnet.id
  nsg_id              = null
  nic_info = {
    ig = {
      private_ip_address   = null
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.naming_convention_info, { name = "ig" })
  tags                   = {}
}

module "nic_obj_trust" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = "southeastasia"
  resource_group_name = local.resource_group_name
  instance_count   = local.vm_instance_count
  subnet_id           = data.azurerm_subnet.egress_subnet.id
  nsg_id              = null
  nic_info = {
    eg = {
      private_ip_address   = null
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.naming_convention_info, { name = "eg" })
  tags                   = {}
}

module "nic_obj_managment" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = "southeastasia"
  resource_group_name = local.resource_group_name
  instance_count   = local.vm_instance_count
  subnet_id           = data.azurerm_subnet.tmt_subnet.id
  nsg_id              = null
  nic_info = {
    tmt = {
      private_ip_address   = null
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.naming_convention_info, { name = "tmt" })
  tags                   = {}
}

