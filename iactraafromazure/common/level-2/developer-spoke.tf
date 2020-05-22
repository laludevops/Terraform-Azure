locals {
  developer_spoke_naming_convention_info = merge(var.naming_convention_info, { "zone" = var.ds_zone_name, "tier" = var.ds_tier_name })
}

data "azurerm_subnet" "ds_subnet" {
  name                 = var.ds_zone_subnet_name
  virtual_network_name = var.ds_zone_vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_network_security_group" "ds_nsg" {
  name                = var.ds_zone_network_security_group_name
  resource_group_name = var.resource_group_name
}

module "ds_vm" {
  source              = "../../../iac.terraform/modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.ds_instance_count
  image               = var.ds_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.ds_subnet.id
    nsg_id             = data.azurerm_network_security_group.ds_nsg.id
    private_ip_address = null
    nics = {
      "${local.developer_spoke_naming_convention_info.name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  vm_size                = var.ds_size
  admin_username         = var.ds_admin_username
  admin_password         = var.ds_admin_password
  naming_convention_info = merge(local.developer_spoke_naming_convention_info, { name = var.ds_name })
  diag_object = {
    log_analytics_workspace_id = var.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = {}
  # type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = {
    encrypt_operation          = "EnableEncryption"
    vault_url                  = "https://akvirasisdsdeveznavt.vault.azure.net/"
    vault_resource_id          = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
    vault_encryption_algorithm = "RSA-OAEP"
    vault_volume_type          = "OS"
  }
}


# managed disk 
module "managed_disk_obj" {
  source                 = "../../../iac.terraform/modules/az-terraform-managed-disk"
  location               = var.location
  resource_group_name    = var.resource_group_name
  instance_count         = var.ds_instance_count
  storage_account_type   = "Standard_LRS"
  create_option          = "Empty"
  disk_size_gb           = "2"
  naming_convention_info = merge(local.developer_spoke_naming_convention_info, { name = var.managed_disk_name })
  tags                   = {}
  keyvault_id            = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_managed_disk_association" {
  count              = var.ds_instance_count
  managed_disk_id    = module.managed_disk_obj.disk_output[count.index].id
  virtual_machine_id = module.ds_vm.vm_output[count.index].id
  lun                = "10"
  caching            = "ReadWrite"
  depends_on         = [module.managed_disk_obj, module.ds_vm]
}

module "developer_spoke_asg" {
  source                 = "../../../iac.terraform/modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.resource_group_name
  naming_convention_info = merge(local.developer_spoke_naming_convention_info, { name = var.asg_name })
  tags                   = {}
}

resource "azurerm_network_interface_application_security_group_association" "dev_spoke_asg_nic_obj" {
  count                         = var.ds_instance_count
  network_interface_id          = module.ds_vm.vm_nic_output[count.index].id
  application_security_group_id = module.developer_spoke_asg.asg_output.id
  ip_configuration_name         = module.ds_vm.vm_nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.ds_vm, module.developer_spoke_asg]
}
