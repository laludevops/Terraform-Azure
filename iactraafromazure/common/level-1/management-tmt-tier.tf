
# data "azurerm_shared_image_version" "ad_ds_gallery_image" {
#   name                = "1.0.0"            //"1.0.3"
#   image_name          = "GT-GCCS-StandardBuild-Windows-Server-2019-04-06"                //"windowsdevmachine01"
#   gallery_name        = "sigirincmn001"                     //"irasdev_sharedimagegallery"
#   resource_group_name = "rg-sig-irin-cmn-001" //"rg-secteam-roniel"
# }


data "azurerm_shared_image_version" "ad_ds_gallery_image" {
  name                = "1.0.3"
  image_name          = "windowsdevmachine01"
  gallery_name        = "irasdev_sharedimagegallery"
  resource_group_name = "rg-secteam-roniel"
}


# data "azurerm_shared_image" "ad_ds_gallery_image" {
#   name                =   "GT-GCCS-StandardBuild-Windows-Server-2019-04-06"           //"1.0.3"
#   gallery_name        = "sigirincmn001"                     //"irasdev_sharedimagegallery"
#   resource_group_name = "rg-sig-irin-cmn-001" //"rg-secteam-roniel"
# }


locals {
  ad_ds_naming_convention_info = merge(local.management_tmt_tier_naming_convention_info, {
    tier = var.management_tier_name
    name = var.ad_ds_name
  })
  ad_ds_tags = merge(local.landing_zone_tags, {})
}



module "common_management_tmt_ad_ds_asg" {
  source                 = "../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = module.level_1_resource_groups.rg_output.management_spoke_nsg.name
  naming_convention_info = local.ad_ds_naming_convention_info
  tags                   = local.ad_ds_tags
}

# ### Need additional scripts for Certificate Services
# ######### Start - Active Directory Domain Service (AD DS) #########
module "common_management_tmt_ad_ds_vm" {
  source              = "../../modules/az-terraform-vm"
  location            = data.azurerm_shared_image_version.ad_ds_gallery_image.location
  resource_group_name = module.level_1_resource_groups.rg_output.common_mgmt_tmt_adds.name
  instance_count      = var.ad_ds_instance_count
  # custom_image_id     = data.azurerm_shared_image_version.ad_ds_gallery_image.id
  vm_size             = var.ad_ds_size
  os_type             = "windows"
  license_type        = "Windows_Client"
  image = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  admin_username = var.ad_ds_admin_username
  admin_password = var.ad_ds_admin_password
  nic_info = {
    subnet_id = lookup(lookup(module.management_tmt_0002_tier.snet_output, "0002", {}), "id", "")
    nsg_id    = lookup(lookup(lookup(module.management_tmt_0002_tier.snet_nsg_output, "0002", {}), "nsg_info", {}), "id", "")
    nics = {
      "${var.ad_ds_name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  naming_convention_info = local.ad_ds_naming_convention_info
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = local.ad_ds_tags
  disk_encryption_info = {
    encrypt_operation          = "EnableEncryption"
    vault_url                  = module.common_azure_key_vault.akv_output.vault_uri
    vault_resource_id          = module.common_azure_key_vault.akv_output.id
    vault_encryption_algorithm = "RSA-OAEP"
    vault_volume_type          = "All"
  }

  dependencies = [module.common_azure_key_vault]
}
# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "common_management_tmt_ad_ds_nic_asg_association" {
  count                         = var.ad_ds_instance_count
  network_interface_id          = module.common_management_tmt_ad_ds_vm.vm_nic_output[count.index].id
  application_security_group_id = module.common_management_tmt_ad_ds_asg.asg_output.id
  ip_configuration_name         = module.common_management_tmt_ad_ds_vm.vm_nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.common_management_tmt_ad_ds_vm, module.common_management_tmt_ad_ds_asg]
}

# ######### End - Active Directory Domain Service (AD DS) #########
