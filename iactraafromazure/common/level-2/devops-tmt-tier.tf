locals {
  dz_tmt_zone_naming_convention_info = merge(var.naming_convention_info, { "zone" = var.dz_name, "tier" = var.dz_tmt_tier_name })
}

data "azurerm_subnet" "dz_tmt" {
  name                 = var.dz_tmt_zone_subnet_name
  virtual_network_name = var.dz_zone_vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_network_security_group" "dz_tmt" {
  name                = var.dz_tmt_zone_network_security_group_name
  resource_group_name = var.resource_group_name
}

# ######### Start - Fortify Software Security Center (SSC) #########
module "fortify_ssc_with_load_balancer" {
  source                 = "../../blueprints/az-terraform-load-balancer-vm"
  location               = var.location
  resource_group_name    = var.resource_group_name
  lb_rules               = var.fortify_ssc_lb_rules
  instance_count         = var.fortify_ssc_lb_instance_count
  vm_size                = var.fortify_ssc_vm_size
  fqdn                   = var.fortify_ssc_fqdn
  admin_username         = var.fortify_ssc_admin_username
  admin_password         = var.fortify_ssc_admin_password
  naming_convention_info = merge(local.dz_tmt_zone_naming_convention_info, { name = var.fortify_ssc_name })
  tags                   = var.tags

  image = var.fortify_ssc_image

  nic_info = {
    subnet_id          = data.azurerm_subnet.dz_tmt.id
    nsg_id             = data.azurerm_network_security_group.dz_tmt.id
    private_ip_address = null
  }

  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }

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
# ######### End - Fortify Software Security Center (SSC) #########


# ######### Start - Fortify Web Inspector (WI) #########
module "fortify_wi_vm" {
  source              = "../../modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.fortify_wi_instance_count
  image = var.fortify_wi_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.dz_tmt.id
    nsg_id             = data.azurerm_network_security_group.dz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.fortify_wi_vm_size
  fqdn                   = var.fortify_wi_fqdn
  admin_username         = var.fortify_wi_admin_username
  admin_password         = var.fortify_wi_admin_password
  naming_convention_info = merge(local.dz_tmt_zone_naming_convention_info, { name = var.fortify_wi_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = var.tags
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - Fortify Web Inspector (WI) #########


# ######### Start - Build #########
module "build_vm" {
  source              = "../../modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.build_vm_instance_count
  image = var.build_vm_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.dz_tmt.id
    nsg_id             = data.azurerm_network_security_group.dz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.build_vm_size
  fqdn                   = var.build_vm_fqdn
  admin_username         = var.build_vm_admin_username
  admin_password         = var.build_vm_admin_password
  naming_convention_info = merge(local.dz_tmt_zone_naming_convention_info, { name = var.build_vm_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = var.tags
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - Build #########


# ######### Start - Tosca Agent #########
module "tosca_agent_vm" {
  source              = "../../modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.tosca_agent_instance_count
  image = var.tosca_agent_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.dz_tmt.id
    nsg_id             = data.azurerm_network_security_group.dz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.tosca_agent_size
  fqdn                   = var.tosca_agent_fqdn
  admin_username         = var.tosca_agent_admin_username
  admin_password         = var.tosca_agent_admin_password
  naming_convention_info = merge(local.dz_tmt_zone_naming_convention_info, { name = var.tosca_agent_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = var.tags
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - Tosca Agent  #########


# ######### Start - Tosca Connect #########
module "tosca_connect_vm" {
  source              = "../../modules/az-terraform-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  instance_count      = var.tosca_connect_instance_count
  image = var.tosca_connect_image
  nic_info = {
    subnet_id          = data.azurerm_subnet.dz_tmt.id
    nsg_id             = data.azurerm_network_security_group.dz_tmt.id
    private_ip_address = null
  }
  vm_size                = var.tosca_connect_size
  fqdn                   = var.tosca_connect_fqdn
  admin_username         = var.tosca_connect_admin_username
  admin_password         = var.tosca_connect_admin_password
  naming_convention_info = merge(local.dz_tmt_zone_naming_convention_info, { name = var.tosca_connect_name })
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  tags = var.tags
  type_handler_version = var.vm_extension_type_handler_version
  disk_encryption_info = var.vm_disk_encryption_info
}
# ######### End - Tosca Connect  #########
