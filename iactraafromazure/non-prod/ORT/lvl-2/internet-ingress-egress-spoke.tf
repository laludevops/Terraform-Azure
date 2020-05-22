locals {
  internet_ingress_egress_naming_convention_info = {
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.internet_zone_name
    tier         = var.na_tier_name
  }
  internet_ingress_egress_tags = merge(local.landing_zone_tags, {})
}

//public ip for ingress nic
module "internet_egress_nic_pip" {
  source              = "../../../modules/az-terraform-network-public-ip"
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  location            = var.location
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, {
    tier = var.ingress_tier_name
    name = var.internet_ig_eg_palo_alto_nic_untrust_name
  })
  tags = local.internet_ingress_egress_tags
  sku  = "Standard"
}


//ingress NIC 
module "internet_ig_eg_palo_alto_nic_untrust" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  instance_count      = var.internet_palo_vm_instance_count
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_internet_ingress_egress_ingress_0001_tier_info.id
  nsg_id              = null
  nic_info = {
    ig = {
      private_ip_address   = ["172.24.115.164", "172.24.115.166"]
      is_primary           = true
      public_ip_address_id = null
    }
    pip = {
      private_ip_address   = null
      is_primary           = false
      public_ip_address_id = module.internet_egress_nic_pip.pip_output.id
    }
  }
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_nic_untrust_name })
  tags                   = local.internet_ingress_egress_tags
}

//egress NIC 
module "internet_ig_eg_palo_alto_nic_trust" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  instance_count      = var.internet_palo_vm_instance_count
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_internet_ingress_egress_egress_0001_tier_info.id
  nsg_id              = null
  nic_info = {
    eg = {
      private_ip_address   = ["172.24.115.196", "172.24.115.197"]
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_nic_trust_name })
  tags                   = local.internet_ingress_egress_tags
}

//management NIC 
module "internet_ig_eg_palo_alto_nic_management" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  instance_count      = var.internet_palo_vm_instance_count
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_internet_ingress_egress_tmt_0001_tier_info.id
  nsg_id              = null
  nic_info = {
    tmt = {
      private_ip_address   = ["172.24.115.228", "172.24.115.229"]
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_nic_management_name })
  tags                   = local.internet_ingress_egress_tags
}

# //asg for Palo Alto

module "internet_hub_ig_eg_palo_alto_management_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.internet_ingress_egress_asg_resource_group_name
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_management_asg_name })
  tags                   = local.internet_ingress_egress_tags
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "internet_hub_ig_eg_palo_alto_management_asg_nic_obj" {
  count                         = var.internet_palo_vm_instance_count
  network_interface_id          = module.internet_ig_eg_palo_alto_nic_management.nic_output[count.index].id
  application_security_group_id = module.internet_hub_ig_eg_palo_alto_management_asg.asg_output.id
  ip_configuration_name         = module.internet_ig_eg_palo_alto_nic_management.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.internet_ig_eg_palo_alto_with_lb, module.internet_hub_ig_eg_palo_alto_management_asg]
}

module "internet_hub_ig_eg_palo_alto_untrust_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.internet_ingress_egress_asg_resource_group_name
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_untrust_asg_name })
  tags                   = local.internet_ingress_egress_tags
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "internet_hub_ig_eg_palo_alto_untrust_asg_nic_obj" {
  count                         = var.internet_palo_vm_instance_count
  network_interface_id          = module.internet_ig_eg_palo_alto_nic_untrust.nic_output[count.index].id
  application_security_group_id = module.internet_hub_ig_eg_palo_alto_untrust_asg.asg_output.id
  ip_configuration_name         = module.internet_ig_eg_palo_alto_nic_untrust.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.internet_ig_eg_palo_alto_with_lb, module.internet_hub_ig_eg_palo_alto_untrust_asg]
}

module "internet_hub_ig_eg_palo_alto_trust_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.internet_ingress_egress_asg_resource_group_name
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_trust_asg_name })
  tags                   = local.internet_ingress_egress_tags
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "internet_hub_ig_eg_palo_alto_trust_asg_nic_obj" {
  count                         = var.internet_palo_vm_instance_count
  network_interface_id          = module.internet_ig_eg_palo_alto_nic_trust.nic_output[count.index].id
  application_security_group_id = module.internet_hub_ig_eg_palo_alto_trust_asg.asg_output.id
  ip_configuration_name         = module.internet_ig_eg_palo_alto_nic_trust.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.internet_ig_eg_palo_alto_with_lb, module.internet_hub_ig_eg_palo_alto_trust_asg]
}

//public ip for palo alto load balancer
module "internet_palo_alto_lb_public_ip" {
  source                 = "../../../modules/az-terraform-network-public-ip"
  resource_group_name    = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  location               = var.location
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_name })
  tags                   = local.internet_ingress_egress_tags
  sku                    = "Standard"
}

//Create Palo Alto vms with lb 
module "internet_ig_eg_palo_alto_with_lb" {
  source                             = "../../../blueprints/az-terraform-load-balancer-vm"
  vm_location                        = var.location
  vm_resource_group_name             = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  vm_instance_count                  = var.internet_palo_vm_instance_count
  vm_size                            = var.internet_palo_vm_size
  vm_admin_username                  = var.internet_palo_vm_admin_username
  vm_admin_password                  = var.internet_palo_vm_admin_password
  vm_naming_convention_info          = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_name })
  vm_tags                            = local.internet_ingress_egress_tags
  vm_os_type                         = var.internet_palo_vm_os_type
  vm_disable_password_authentication = true
  vm_image = {
    publisher = var.internet_palo_vm_image_publisher
    offer     = var.internet_palo_vm_image_offer
    sku       = var.internet_palo_vm_image_sku
    version   = var.internet_palo_vm_image_version
  }
  vm_marketplace = {
    name      = var.internet_palo_vm_marketplace_name
    publisher = var.internet_palo_vm_marketplace_publisher
    product   = var.internet_palo_vm_marketplace_product
  }
  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  vm_disk_encryption_info = null
  vm_nic_info             = null
  vm_nic_ids = [
    [module.internet_ig_eg_palo_alto_nic_management.nic_output[0].id, module.internet_ig_eg_palo_alto_nic_untrust.nic_output[0].id, module.internet_ig_eg_palo_alto_nic_trust.nic_output[0].id],
    [module.internet_ig_eg_palo_alto_nic_management.nic_output[1].id, module.internet_ig_eg_palo_alto_nic_untrust.nic_output[1].id, module.internet_ig_eg_palo_alto_nic_trust.nic_output[1].id],
  ]
  nic_lb_association = [
    {
      ip_configuration_name = module.internet_ig_eg_palo_alto_nic_untrust.nic_output[0].ip_configuration[0].name
      nic_id                = module.internet_ig_eg_palo_alto_nic_untrust.nic_output[0].id
    },
    {
      ip_configuration_name = module.internet_ig_eg_palo_alto_nic_untrust.nic_output[1].ip_configuration[0].name
      nic_id                = module.internet_ig_eg_palo_alto_nic_untrust.nic_output[1].id
    }
  ]
  dependencies              = [module.internet_ig_eg_palo_alto_nic_untrust, module.internet_ig_eg_palo_alto_nic_trust, module.internet_ig_eg_palo_alto_nic_management, module.ort_level_2_resource_groups]
  lb_resource_group_name    = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_palo_vm_resource_group_name", {}), "name", "")
  lb_location               = var.location
  lb_static_ip             = "172.24.115.208"
  lb_public_ip_address_id   = module.internet_palo_alto_lb_public_ip.pip_output.id
  lb_subnet_id              = null #data.terraform_remote_state.ort_level_1.outputs.ort_internet_ingress_egress_tmt_0001_tier_info.id
  lb_naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, { name = var.internet_ig_eg_palo_alto_name })
  lb_sku                    = var.internet_palo_lb_sku
  lb_rules = {
    rule_one = {
      probe_port              = var.internet_palo_lb_rules_probe_port
      probe_protocol          = var.internet_palo_lb_rules_probe_protocol
      lb_port                 = var.internet_palo_lb_rules_lb_port
      backend_port            = var.internet_palo_lb_rules_backend_port
      load_distribution       = var.internet_palo_lb_rules_load_distribution
      idle_timeout_in_minutes = var.internet_palo_lb_rules_idle_timeout_in_minutes
      request_path            = "/"
    }
  }
  lb_tags = local.internet_ingress_egress_tags
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

module "internet_ingress_egress_lb" {
  source              = "../../../modules/az-terraform-network-load-balancer"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "internet_lb_resource_group_name"), "name")
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_internet_ingress_egress_egress_0001_tier_info.id
  sku                 = var.internet_palo_lb_sku
  lb_rules = {
    rule_one = {
      probe_port              = var.internet_ingress_egress_lb_rules_probe_port
      probe_protocol          = var.internet_ingress_egress_lb_rules_probe_protocol
      lb_port                 = var.internet_ingress_egress_lb_rules_lb_port
      backend_port            = var.internet_ingress_egress_lb_rules_backend_port
      load_distribution       = var.internet_ingress_egress_lb_rules_load_distribution
      idle_timeout_in_minutes = var.internet_ingress_egress_lb_rules_idle_timeout_in_minutes
      request_path            = "/"
    }
  }
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log = [
      ["LoadBalancerAlertEvent", true, true, 80],
      ["LoadBalancerProbeHealthStatus", true, true, 80],
    ]
    metric = [
      ["AllMetrics", true, true, 80],
    ]
  }
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info,
    {
      tier = var.egress_tier_name
      name = var.internet_ingress_egress_lb_name
  })
  tags         = local.internet_ingress_egress_tags
  dependencies = [module.ort_level_2_resource_groups.rg_output]
}


resource "azurerm_network_interface_backend_address_pool_association" "internet_ingress_egress_lb_egress_nic_association" {
  count                   = var.internet_palo_vm_instance_count
  network_interface_id    = module.internet_ig_eg_palo_alto_nic_trust.nic_output[count.index].id
  ip_configuration_name   = module.internet_ig_eg_palo_alto_nic_trust.nic_output[count.index].ip_configuration[0].name
  backend_address_pool_id = module.internet_ingress_egress_lb.azurerm_lb_backend_address_pool_output.id
  depends_on              = [module.internet_ig_eg_palo_alto_nic_trust, module.internet_ingress_egress_lb]
}

