locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "we"
}


locals {
  resource_group_name = "vm-managed-disk"
  vnet_name           = "v2-vnet-managed_disk_iac"
  location            = "southeastasia"
  naming_convention_info = {
    "name"         = "we"
    "agency_code"  = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags     = {}
  vm_count = 2
  loga_id  = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-lz-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-mad-001"
}


data "azurerm_subnet" "example" {
  name                 = "v2-snet-managed_disk_1"
  virtual_network_name = "v2-vnet-managed_disk_iac"
  resource_group_name  = "v2-rg-managed_disk_iac"
}

module "virtual_machine" {
  source              = "../../"
  location            = local.location
  resource_group_name = local.resource_group_name
  instance_count      = local.vm_count
  image = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "rs4-pro"
    version   = "latest"
  }
  nic_info = {
    subnet_id = data.azurerm_subnet.example.id
    nsg_id    = null
    nics = {
      "${local.naming_convention_info.name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  vm_size                = "Standard_D4s_v3"
  admin_username         = "admin123"
  admin_password         = "adMin%6541"
  naming_convention_info = local.naming_convention_info
  tags                   = {}
  dependencies = [module.managed_disk_obj]
  disk_encryption_info = {
    encrypt_operation          = "EnableEncryption"
    vault_url                  = "https://akvirasisdsdeveznavt.vault.azure.net/"
    vault_resource_id          = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
    vault_encryption_algorithm = "RSA-OAEP"
    vault_volume_type          = "All"
  }
}



# managed disk 
module "managed_disk_obj" {
  source                 = "../../../az-terraform-managed-disk"
  location               = local.location
  resource_group_name    = local.resource_group_name
  instance_count         = local.vm_count
  storage_account_type   = "Standard_LRS"
  create_option          = "Empty"
  disk_size_gb           = "1"
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  keyvault_id            = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
  enable_disk_encryption = "false"
}


resource "azurerm_virtual_machine_data_disk_attachment" "vm_managed_disk_association" {
  count              = local.vm_count
  managed_disk_id    = module.managed_disk_obj.disk_output[count.index].id
  virtual_machine_id = module.virtual_machine.vm_output[count.index].id
  lun                = "10"
  caching            = "ReadWrite"
  depends_on         = [module.virtual_machine, module.managed_disk_obj]
}
