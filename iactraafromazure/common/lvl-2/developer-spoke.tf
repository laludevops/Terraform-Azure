locals {

  developer_spoke_naming_convention_info = merge(local.devops_zone_naming_convention_info, {
    "tier" = var.na_tier_name
  })
  developer_spoke_tags = merge(local.landing_zone_level_tags, {})
}

data "azurerm_shared_image_version" "ad_developer_vm_gallery_image" {
  name                = var.developer_vm_gallery_image_version
  image_name          = var.developer_vm_gallery_image_name
  gallery_name        = var.developer_vm_gallery_name
  resource_group_name = var.developer_vm_gallery_image_resource_group_name
}

module "developer_vm" {
  source              = "../../modules/az-terraform-vm"
  location            = var.location
  resource_group_name = lookup(lookup(module.cmn_level_2_resource_groups.rg_output, "developer_vm_resource_group_name", {}), "name", "")
  instance_count      = var.developer_vm_instance_count
  custom_image_id     = data.azurerm_shared_image_version.ad_developer_vm_gallery_image.id
  nic_info = {
    subnet_id          = data.terraform_remote_state.cmn_level_1.outputs.developer_dev_tier_info.id #data.azurerm_subnet.developer_vm_subnet.id
    nsg_id             = data.terraform_remote_state.cmn_level_1.outputs.developer_dev_tier_info.nsg_id
    private_ip_address = null
    nics = {
      "${var.developer_vm_name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  os_type                = var.developer_vm_os_type
  vm_size                = var.developer_vm_size
  admin_username         = var.developer_vm_admin_username
  admin_password         = var.developer_vm_admin_password
  naming_convention_info = merge(local.developer_spoke_naming_convention_info, { name = var.developer_vm_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = merge(local.landing_zone_level_tags, {})
  disk_encryption_info = {
    encrypt_operation          = "EnableEncryption"
    vault_url                  = data.terraform_remote_state.cmn_level_1.outputs.common_azure_key_vault_info.uri
    vault_resource_id          = data.terraform_remote_state.cmn_level_1.outputs.common_azure_key_vault_info.id
    vault_encryption_algorithm = "RSA-OAEP"
    vault_volume_type          = "OS"
  }
}


# # managed disk 
# module "managed_disk_obj" {
#   source                 = "../../modules/az-terraform-managed-disk"
#   location               = var.location
#   resource_group_name    = lookup(lookup(module.cmn_level_2_resource_groups.rg_output, "cmn_developer_spoke_vm_resource_group_name", {}), "name", "")
#   instance_count         = var.developer_vm_instance_count
#   storage_account_type   = "Standard_LRS"
#   create_option          = "Empty"
#   disk_size_gb           = "2"
#   naming_convention_info = merge(local.developer_spoke_naming_convention_info, { name = var.managed_disk_name })
#   tags                   = merge(local.developer_spoke_tags, {})
#   keyvault_id            = data.terraform_remote_state.cmn_level_1.outputs.common_azure_key_vault_info.id
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "vm_managed_disk_association" {
#   count              = var.developer_vm_instance_count
#   managed_disk_id    = module.managed_disk_obj.disk_output[count.index].id
#   virtual_machine_id = module.developer_vm.vm_output[count.index].id
#   lun                = "10"
#   caching            = "ReadWrite"
#   depends_on         = [module.managed_disk_obj, module.developer_vm]
# }

module "developer_spoke_asg" {
  source                 = "../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.developer_spoke_asg_resource_group_name
  naming_convention_info = merge(local.developer_spoke_naming_convention_info, { name = var.developer_spoke_asg_name })
  tags                   = merge(local.developer_spoke_tags, {})
}

resource "azurerm_network_interface_application_security_group_association" "dev_spoke_asg_nic_obj" {
  count                         = var.developer_vm_instance_count
  network_interface_id          = module.developer_vm.vm_nic_output[count.index].id
  application_security_group_id = module.developer_spoke_asg.asg_output.id
  ip_configuration_name         = module.developer_vm.vm_nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.developer_vm, module.developer_spoke_asg]
}
