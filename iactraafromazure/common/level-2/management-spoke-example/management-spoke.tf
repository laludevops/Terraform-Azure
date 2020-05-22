locals {

  mz_tmt_zone_naming_convention_info = merge(var.naming_convention_info, { "zone" = var.mz_zone_name, "tier" = var.mz_tmt_tier_name })
  mz_db_zone_naming_convention_info  = merge(var.naming_convention_info, { "zone" = var.mz_zone_name, "tier" = var.mz_db_tier_name })
  loga_id                            = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-lz-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-mad-001"
}

data "azurerm_subnet" "mz_tmt" {
  name                 = var.mz_tmt_zone_subnet_name
  virtual_network_name = var.mz_zone_vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_network_security_group" "mz_tmt" {
  name                = var.mz_tmt_zone_network_security_group_name
  resource_group_name = var.resource_group_name
}

# data "azurerm_shared_image_version" "fssc_gallery_image" {
#   name                = "0.0.4"                       
#   image_name          = "iras_dev_wave1_010420_image" 
#   gallery_name        = "sigirincmn001"               
#   resource_group_name = "rg-sig-irin-cmn-001"         
# }
data "azurerm_shared_image_version" "fssc_gallery_image" {
  name                = "1.0.3"
  image_name          = "windowsdevmachine01"
  gallery_name        = "irasdev_sharedimagegallery"
  resource_group_name = "rg-secteam-roniel"
}
# ### Need more details to complete the script
# ######### Start - Pano Server #########
# module "pano_vm" {
#   source              = "../../../../iac.terraform/modules/az-terraform-vm"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   instance_count      = var.pano_instance_count
#   image               = var.pano_image
#   nic_info = {
#     subnet_id          = data.azurerm_subnet.mz_tmt.id
#     nsg_id             = data.azurerm_network_security_group.mz_tmt.id
#     private_ip_address = null
#     nics = {
#       "${var.pano_name}" = {
#         private_ip_address   = null
#         is_primary           = true
#         public_ip_address_id = null
#       }
#     }
#   }
#   os_type                = var.pano_os_type
#   marketplace            = {
#     name      = var.palo_vm_marketplace_name
#     publisher = var.palo_vm_marketplace_publisher
#     product   = var.palo_vm_marketplace_product
#   }
#   vm_size                = var.pano_size
#   admin_username         = var.pano_admin_username
#   admin_password         = var.pano_admin_password
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.pano_name })
#   diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = []
#     metric                     = [["AllMetrics", true, true, 80], ]
#   }
#   tags = {}
#   #type_handler_version = var.vm_extension_type_handler_version
#   disk_encryption_info = null #var.vm_disk_encryption_info
# }


# module "pano_asg" {
#   source                 = "../../../../iac.terraform/modules/az-terraform-network-asg"
#   location               = var.location
#   resource_group_name    = var.resource_group_name
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.pano_asg_name })
#   tags                   = {}
# }
# resource "azurerm_network_interface_application_security_group_association" "pano_asg_nic_obj" {
#   count                         = var.pano_instance_count
#   network_interface_id          = module.pano_vm.vm_nic_output[count.index].id
#   application_security_group_id = module.pano_asg.asg_output.id
#   ip_configuration_name         = module.pano_vm.vm_nic_output[count.index].ip_configuration[0].name
#   depends_on                    = [module.pano_vm, module.pano_asg]
# }

# module "pano_managed_disk_obj" {
#   source                 = "../../../../iac.terraform/modules/az-terraform-managed-disk"
#   location               = var.location
#   resource_group_name    = var.resource_group_name
#   instance_count         = var.pano_instance_count
#   storage_account_type   = "Standard_LRS"
#   create_option          = "Empty"
#   disk_size_gb           = "2"
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.pano_managed_disk_name })
#   tags                   = {}
#   keyvault_id            = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
# }
# resource "azurerm_virtual_machine_data_disk_attachment" "panovm_managed_disk_association" {
#   count              = var.pano_instance_count
#   managed_disk_id    = module.pano_managed_disk_obj.disk_output[count.index].id
#   virtual_machine_id = module.pano_vm.vm_output[count.index].id
#   lun                = "10"
#   caching            = "ReadWrite"
#   depends_on         = [module.pano_managed_disk_obj, module.pano_vm]
# }

# ######### End - Pano #########

# ######### Start - Fortify SSC #########
# module "fortify_ssc_vm" {
#   source              = "../../../../iac.terraform/modules/az-terraform-vm"
#   location            = var.location            #data.azurerm_shared_image_version.fssc_gallery_image.location
#   resource_group_name = var.resource_group_name #data.azurerm_shared_image_version.fssc_gallery_image.resource_group_name
#   instance_count      = var.fortify_ssc_instance_count
#   custom_image_id     = data.azurerm_shared_image_version.fssc_gallery_image.id
#   nic_info = {
#     subnet_id          = data.azurerm_subnet.mz_tmt.id
#     nsg_id             = data.azurerm_network_security_group.mz_tmt.id
#     private_ip_address = null
#     nics = {
#       "${var.fortify_ssc_name}" = {
#         private_ip_address   = null
#         is_primary           = true
#         public_ip_address_id = null
#       }
#     }

#   }
#   os_type                = var.fortify_os_type
#   vm_size                = var.fortify_ssc_size
#   admin_username         = var.fortify_ssc_admin_username
#   admin_password         = var.fortify_ssc_admin_password
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.fortify_ssc_name })
#   diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = []
#     metric                     = [["AllMetrics", true, true, 80], ]
#   }
#   tags = {}
#   #type_handler_version = var.vm_extension_type_handler_version
#   disk_encryption_info = null #var.vm_disk_encryption_info
# }
# module "fortify_ssc_asg" {
#   source                 = "../../../../iac.terraform/modules/az-terraform-network-asg"
#   location               = var.location
#   resource_group_name    = var.resource_group_name
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.fortify_ssc_asg_name })
#   tags                   = {}
# }
# resource "azurerm_network_interface_application_security_group_association" "fortify_ssc_asg_nic_obj" {
#   count                         = var.fortify_ssc_instance_count
#   network_interface_id          = module.fortify_ssc_vm.vm_nic_output[count.index].id
#   application_security_group_id = module.fortify_ssc_asg.asg_output.id
#   ip_configuration_name         = module.fortify_ssc_vm.vm_nic_output[count.index].ip_configuration[0].name
#   depends_on                    = [module.fortify_ssc_vm, module.fortify_ssc_asg]
# }
# ######### End - Fortify SSC #########


# # ######### Start - WSUS virtual machines with load balancer #########
# module "wsus_vm_with_load_balancer" {
#   source                 = "../../../blueprints/az-terraform-load-balancer-vm"
#   location               = var.location
#   resource_group_name    = var.resource_group_name
#   instance_count         = var.wsus_lb_instance_count
#   vm_size                = var.wsusvm_size
#   fqdn                   = var.wsus_fqdn
#   admin_username         = var.wsusadmin_username
#   admin_password         = var.wsus_admin_password
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.wsus_name })
#   tags                   = {}

#   image = var.wsus_image

#   nic_info = {
#     subnet_id          = data.azurerm_subnet.mz_tmt.id
#     nsg_id             = data.azurerm_network_security_group.mz_tmt.id
#     private_ip_address = null
#   }

#   vm_diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = []
#     metric                     = [["AllMetrics", true, true, 80], ]
#   }

#   lb_rules = var.wsus_lb_rules

#   lb_diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log = [
#       ["LoadBalancerAlertEvent", true, true, 80],
#       ["LoadBalancerProbeHealthStatus", true, true, 80],
#     ]
#     metric = [
#       ["AllMetrics", true, true, 80],
#     ]
#   }
#   type_handler_version = var.vm_extension_type_handler_version
#   disk_encryption_info = var.vm_disk_encryption_info
# }
# # ######### End - WSUS virtual machines with load balancer #########


# ######### Start - CA Server #########
module "ca_vm" {
  source              = "../../../../iac.terraform/modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.ca_instance_count
  image               = var.ca_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.mz_tmt.id
    nsg_id             = data.azurerm_network_security_group.mz_tmt.id
    private_ip_address = null
    nics = {
      "${var.ca_name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  vm_size                = var.ca_size
  admin_username         = var.ca_admin_username
  admin_password         = var.ca_admin_password
  naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.ca_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags                 = {}
  #type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = null#var.vm_disk_encryption_info
}
module "ca_asg" {
  source                 = "../../../../iac.terraform/modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.resource_group_name
  naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.fortify_ssc_asg_name })
  tags                   = {}
}
resource "azurerm_network_interface_application_security_group_association" "ca_asg_nic_obj" {
  count                         = var.ca_instance_count
  network_interface_id          = module.ca_vm.vm_nic_output[count.index].id
  application_security_group_id = module.ca_asg.asg_output.id
  ip_configuration_name         = module.ca_vm.vm_nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.ca_vm, module.ca_asg]
}
# ######### End - CA Server #########


# # ######### Start - New Server #########
# module "new_vm" {
#   source              = "../../../../iac.terraform/modules/az-terraform-vm"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   instance_count      = var.new_instance_count
#   image               = var.new_image
#   nic_info = {
#     subnet_id          = data.azurerm_subnet.mz_tmt.id
#     nsg_id             = data.azurerm_network_security_group.mz_tmt.id
#     private_ip_address = null
#   }
#   vm_size                = var.new_size
#   fqdn                   = var.new_fqdn
#   admin_username         = var.new_admin_username
#   admin_password         = var.new_admin_password
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.new_name })
#   diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = []
#     metric                     = [["AllMetrics", true, true, 80], ]
#   }
#   tags                 = {}
#   type_handler_version = var.vm_extension_type_handler_version
#   disk_encryption_info = var.vm_disk_encryption_info
# }
# # ######### End - New Server #########

# module "wsus_server_sql" {
#   source              = "../../../../iac.terraform/modules/az-terraform-azure-sql"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   databases = {
#     database_1 = {
#       name                             = "Management_Update_Configuration"
#       collation                        = "SQL_LATIN1_GENERAL_CP1_CI_AS"
#       edition                          = "Standard"
#       requested_service_objective_name = "S4"
#       max_size_bytes                   = "268435456000"
#     }
#   }
#   diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = [["AllLogs", true, true, 80], ]
#     metric                     = [["AllMetrics", true, true, 80], ]
#   }
#   naming_convention_info = merge(local.mz_db_zone_naming_convention_info, { name = var.wsus_server_sql_name })
#   tags                   = var.tags
# }
