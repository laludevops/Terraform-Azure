locals {
  mz_tmt_zone_naming_convention_info = merge(var.naming_convention_info, { "zone" = var.mz_zone_name, "tier" = var.mz_tmt_tier_name })
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

# # ### Need additional scripts for Certificate Services
# # ######### Start - Active Directory Domain Service (AD DS) #########
# module "ad_ds_vm" {
#   source              = "../../modules/az-terraform-vm"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   instance_count      = var.ad_ds_instance_count
#   image = var.ad_ds_image
#   nic_info = {
#     subnet_id          = data.azurerm_subnet.mz_tmt.id
#     nsg_id             = data.azurerm_network_security_group.mz_tmt.id
#     private_ip_address = null
#   }
#   vm_size                = var.ad_ds_size
#   fqdn                   = var.ad_ds_fqdn
#   admin_username         = var.ad_ds_admin_username
#   admin_password         = var.ad_ds_admin_password
#   naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.ad_ds_name})
#   diag_object = {
#     log_analytics_workspace_id = local.loga_id
#     log                        = []
#     metric                     = [["AllMetrics", true, true, 80], ]
#   }
#   tags = {}
#   type_handler_version = var.vm_extension_type_handler_version
#   disk_encryption_info = var.vm_disk_encryption_info
# }
# # ######### End - Active Directory Domain Service (AD DS) #########


# ### Need more details to complete the script
# ######### Start - Pano Server #########
module "pano_vm" {
  source              = "../../../iac.terraform/modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.pano_instance_count
  image               = var.pano_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.mz_tmt.id
    nsg_id             = data.azurerm_network_security_group.mz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.pano_size
  fqdn                   = var.pano_fqdn
  admin_username         = var.pano_admin_username
  admin_password         = var.pano_admin_password
  naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.pano_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags                 = {}
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - Pano #########


# ######### Start - WSUS virtual machines with load balancer #########
module "wsus_vm_with_load_balancer" {
  source                 = "../../blueprints/az-terraform-load-balancer-vm"
  location               = var.location
  resource_group_name    = var.resource_group_name
  instance_count         = var.wsus_lb_instance_count
  vm_size                = var.wsusvm_size
  fqdn                   = var.wsus_fqdn
  admin_username         = var.wsusadmin_username
  admin_password         = var.wsus_admin_password
  naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.wsus_name })
  tags                   = {}

  image = var.wsus_image

  nic_info = {
    subnet_id          = data.azurerm_subnet.mz_tmt.id
    nsg_id             = data.azurerm_network_security_group.mz_tmt.id
    private_ip_address = null
  }

  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }

  lb_rules = var.wsus_lb_rules

  lb_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log = [
      ["LoadBalancerAlertEvent", true, true, 80],
      ["LoadBalancerProbeHealthStatus", true, true, 80],
    ]
    metric = [
      ["AllMetrics", true, true, 80],
    ]
  }
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - WSUS virtual machines with load balancer #########


######### Start - CA Server #########
module "ca_vm" {
  source              = "../../../iac.terraform/modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.ca_instance_count
  image               = var.ca_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.mz_tmt.id
    nsg_id             = data.azurerm_network_security_group.mz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.ca_size
  fqdn                   = var.ca_fqdn
  admin_username         = var.ca_admin_username
  admin_password         = var.ca_admin_password
  naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.ca_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags                 = {}
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
######### End - CA Server #########


# ######### Start - New Server #########
module "new_vm" {
  source              = "../../../iac.terraform/modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.new_instance_count
  image               = var.new_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.mz_tmt.id
    nsg_id             = data.azurerm_network_security_group.mz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.new_size
  fqdn                   = var.new_fqdn
  admin_username         = var.new_admin_username
  admin_password         = var.new_admin_password
  naming_convention_info = merge(local.mz_tmt_zone_naming_convention_info, { name = var.new_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags                 = {}
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - New Server #########
