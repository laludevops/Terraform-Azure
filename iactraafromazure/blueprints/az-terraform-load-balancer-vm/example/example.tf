locals {
  # For naming convention purpose
  naming_convention_info = {
    name         = "palo"
    agency_code  = "iras"
    project_code = "irasgcc"
    env          = "dev"
    zone         = "z1"
    tier         = "web"
  }
  tags                = {}
  resource_group_name = "palo-alto-sri"
  location            = "southeastasia"
  loga_id             = data.azurerm_log_analytics_workspace.log_example.id
  vm_instance_count   = 2
}

## data used to pull id of log analytics workspace
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = "rg-alex-iac"
}


data "azurerm_subnet" "ingress_subnet" {
  name                 = "ingress-subnet"
  virtual_network_name = "palo-alto-vnet"
  resource_group_name  = "palo-alto-sri"
}

# data "azurerm_network_security_group" "example" {
#   name                = "nsg-irasgcc-dev-s1"
#   resource_group_name = local.resource_group_name
# }

data "azurerm_subnet" "egress_subnet" {
  name                 = "egress-subnet"
  virtual_network_name = "palo-alto-vnet"
  resource_group_name  = "palo-alto-sri"
}

# data "azurerm_network_security_group" "example" {
#   name                = "nsg-irasgcc-dev-s1"
#   resource_group_name = local.resource_group_name
# }

data "azurerm_subnet" "tmt_subnet" {
  name                 = "mgmt-subnet"
  virtual_network_name = "palo-alto-vnet"
  resource_group_name  = "palo-alto-sri"
}

# data "azurerm_network_security_group" "example" {
#   name                = "nsg-irasgcc-dev-s1"
#   resource_group_name = local.resource_group_name
# }


module "pip" {
  source                 = "../../../modules/az-terraform-network-public-ip"
  resource_group_name    = local.resource_group_name
  location               = local.location
  naming_convention_info = local.naming_convention_info
  sku                    = "Standard"
  tags                   = {}
}


module "tosca_server_with_load_balancer" {
  source                             = "../"
  vm_location                        = "southeastasia"
  vm_resource_group_name             = "palo-alto-sri"
  vm_instance_count                  = 2
  vm_size                            = "Standard_DS3_v2"
  vm_admin_username                  = "merlion123"
  vm_admin_password                  = "Sesshomaru21"
  vm_naming_convention_info          = merge(local.naming_convention_info, { name = "tosca" })
  vm_tags                            = {}
  vm_os_type                         = "linux"
  vm_disable_password_authentication = true
  vm_image = {
    publisher = "paloaltonetworks"
    offer     = "vmseries1"
    sku       = "byol"
    version   = "latest"
  }
  vm_marketplace = {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries1"
  }
  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  vm_disk_encryption_info = null
  vm_nic_info             = null
  vm_nic_ids = [
    [module.nic_obj_managment.nic_output[0].id, module.nic_obj_untrust.nic_output[0].id, module.nic_obj_trust.nic_output[0].id],
    [module.nic_obj_managment.nic_output[1].id, module.nic_obj_untrust.nic_output[1].id, module.nic_obj_trust.nic_output[1].id],
  ]
  nic_lb_association = [
    {
      ip_configuration_name = module.nic_obj_untrust.nic_output[0].ip_configuration[0].name
      nic_id                = module.nic_obj_untrust.nic_output[0].id
    },
    {
      ip_configuration_name = module.nic_obj_untrust.nic_output[1].ip_configuration[0].name
      nic_id                = module.nic_obj_untrust.nic_output[1].id
    }
  ]
  dependencies              = [module.nic_obj_untrust.nic_output, module.nic_obj_trust.nic_output, module.nic_obj_managment.nic_output]
  lb_resource_group_name    = "palo-alto-sri"
  lb_location               = "southeastasia"
  lb_public_ip_address_id   = module.pip.pip_output.id
  lb_naming_convention_info = local.naming_convention_info
  lb_sku                    = "Standard"
  lb_rules = {
    rule_one = {
      probe_port              = "443"
      probe_protocol          = "Tcp"
      lb_port                 = "80"
      backend_port            = "80"
      load_distribution       = "Default"
      idle_timeout_in_minutes = 4
      request_path            = "/"
    }
  }
  lb_tags = {}
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
}
