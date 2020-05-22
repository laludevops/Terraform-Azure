locals {
  transit_hub_palo_alto_ingress_egress_naming_convention_info = {
    start_index  = var.intranet_palo_vm_instance_count + 1
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.intranet_zone_name
    tier         = var.na_tier_name
  }
  transit_hub_ingress_egress_tags = merge(local.landing_zone_tags, {})
}

//ingress NIC 
module "transit_hub_ig_eg_palo_alto_nic_untrust" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "transit_hub_palo_vm_resource_group_name", {}), "name", "")
  instance_count      = var.transit_hub_palo_vm_instance_count
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_transit_hub_ingress_0001_tier_info.id
  nsg_id              = null
  nic_info = {
    ig = {
      private_ip_address   = ["10.192.118.196", "10.192.118.197"]
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_hub_ig_eg_palo_alto_nic_untrust_name
  })
  tags = local.transit_hub_ingress_egress_tags
}

//egress NIC 
module "transit_hub_ig_eg_palo_alto_nic_trust" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "transit_hub_palo_vm_resource_group_name", {}), "name", "")
  instance_count      = var.transit_hub_palo_vm_instance_count
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_transit_hub_egress_0001_tier_info.id
  nsg_id              = null
  nic_info = {
    eg = {
      private_ip_address   = ["10.192.118.228", "10.192.118.229"]
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_hub_ig_eg_palo_alto_nic_trust_name })
  tags                   = local.transit_hub_ingress_egress_tags
}

//management NIC 
module "transit_hub_ig_eg_palo_alto_nic_management" {
  source              = "../../../modules/az-terraform-network-nic"
  location            = var.location
  resource_group_name = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "transit_hub_palo_vm_resource_group_name", {}), "name", "")
  instance_count      = var.transit_hub_palo_vm_instance_count
  subnet_id           = data.terraform_remote_state.ort_level_1.outputs.ort_transit_hub_tmt_0001_tier_info.id
  nsg_id              = null
  nic_info = {
    tmt = {
      private_ip_address   = ["10.192.118.68", "10.192.118.69"]
      is_primary           = true
      public_ip_address_id = null
    }
  }
  naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_hub_ig_eg_palo_alto_nic_management_name })
  tags                   = local.transit_hub_ingress_egress_tags
}

# //asg for Palo Alto
module "transit_hub_ig_eg_palo_alto_mgmt_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.transit_hub_asg_resource_group_name
  naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_ig_eg_palo_alto_mgmt_asg_name })
  tags                   = local.transit_hub_ingress_egress_tags
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "transit_hub_ig_eg_palo_alto_mgmt_asg_nic_obj" {
  count                         = var.transit_hub_palo_vm_instance_count
  network_interface_id          = module.transit_hub_ig_eg_palo_alto_nic_management.nic_output[count.index].id
  application_security_group_id = module.transit_hub_ig_eg_palo_alto_mgmt_asg.asg_output.id
  ip_configuration_name         = module.transit_hub_ig_eg_palo_alto_nic_management.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.transit_hub_ig_eg_palo_alto_with_lb, module.transit_hub_ig_eg_palo_alto_mgmt_asg]
}

module "transit_hub_ig_eg_palo_alto_untrust_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.transit_hub_asg_resource_group_name
  naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_ig_eg_palo_alto_untrust_asg_name })
  tags                   = local.transit_hub_ingress_egress_tags
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "transit_hub_ig_eg_palo_alto_untrust_asg_nic_obj" {
  count                         = var.transit_hub_palo_vm_instance_count
  network_interface_id          = module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[count.index].id
  application_security_group_id = module.transit_hub_ig_eg_palo_alto_untrust_asg.asg_output.id
  ip_configuration_name         = module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.transit_hub_ig_eg_palo_alto_with_lb, module.transit_hub_ig_eg_palo_alto_untrust_asg]
}

module "transit_hub_ig_eg_palo_alto_trust_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.transit_hub_asg_resource_group_name
  naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_ig_eg_palo_alto_trust_asg_name })
  tags                   = local.transit_hub_ingress_egress_tags
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "transit_hub_ig_eg_palo_alto_trust_asg_nic_obj" {
  count                         = var.transit_hub_palo_vm_instance_count
  network_interface_id          = module.transit_hub_ig_eg_palo_alto_nic_trust.nic_output[count.index].id
  application_security_group_id = module.transit_hub_ig_eg_palo_alto_trust_asg.asg_output.id
  ip_configuration_name         = module.transit_hub_ig_eg_palo_alto_nic_trust.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.transit_hub_ig_eg_palo_alto_with_lb, module.transit_hub_ig_eg_palo_alto_trust_asg]
}
//Create Palo Alto vms with lb 
module "transit_hub_ig_eg_palo_alto_with_lb" {
  source                             = "../../../blueprints/az-terraform-load-balancer-vm"
  vm_location                        = var.location
  vm_resource_group_name             = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "transit_hub_palo_vm_resource_group_name", {}), "name", "")
  vm_instance_count                  = var.transit_hub_palo_vm_instance_count
  vm_size                            = var.transit_hub_palo_vm_size
  vm_admin_username                  = var.transit_hub_palo_vm_admin_username
  vm_admin_password                  = var.transit_hub_palo_vm_admin_password
  vm_naming_convention_info          = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_hub_ig_eg_palo_alto_name })
  vm_tags                            = local.transit_hub_ingress_egress_tags
  vm_os_type                         = var.transit_hub_palo_vm_os_type
  vm_disable_password_authentication = true
  vm_image = {
    publisher = var.transit_hub_palo_vm_image_publisher
    offer     = var.transit_hub_palo_vm_image_offer
    sku       = var.transit_hub_palo_vm_image_sku
    version   = var.transit_hub_palo_vm_image_version
  }
  vm_marketplace = {
    name      = var.transit_hub_palo_vm_marketplace_name
    publisher = var.transit_hub_palo_vm_marketplace_publisher
    product   = var.transit_hub_palo_vm_marketplace_product
  }
  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  vm_disk_encryption_info = null
  vm_nic_info             = null
  vm_nic_ids = [
    [module.transit_hub_ig_eg_palo_alto_nic_management.nic_output[0].id, module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[0].id, module.transit_hub_ig_eg_palo_alto_nic_trust.nic_output[0].id],
    [module.transit_hub_ig_eg_palo_alto_nic_management.nic_output[1].id, module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[1].id, module.transit_hub_ig_eg_palo_alto_nic_trust.nic_output[1].id],
  ]
  nic_lb_association = [
    {
      ip_configuration_name = module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[0].ip_configuration[0].name
      nic_id                = module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[0].id
    },
    {
      ip_configuration_name = module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[1].ip_configuration[0].name
      nic_id                = module.transit_hub_ig_eg_palo_alto_nic_untrust.nic_output[1].id
    }
  ]
  dependencies              = [module.transit_hub_ig_eg_palo_alto_nic_untrust, module.transit_hub_ig_eg_palo_alto_nic_trust, module.transit_hub_ig_eg_palo_alto_nic_management, module.ort_level_2_resource_groups]
  lb_resource_group_name    = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "transit_hub_palo_vm_resource_group_name", {}), "name", "")
  lb_location               = var.location
  lb_static_ip              = "10.192.118.200"
  lb_public_ip_address_id   = null
  lb_subnet_id              = data.terraform_remote_state.ort_level_1.outputs.ort_transit_hub_tmt_0001_tier_info.id
  lb_naming_convention_info = merge(local.transit_hub_palo_alto_ingress_egress_naming_convention_info, { name = var.transit_hub_ig_eg_palo_alto_name })
  lb_sku                    = var.transit_hub_palo_lb_sku
  lb_rules = {
    rule_one = {
      probe_port              = var.transit_hub_palo_lb_rules_probe_port
      probe_protocol          = var.transit_hub_palo_lb_rules_probe_protocol
      lb_port                 = var.transit_hub_palo_lb_rules_lb_port
      backend_port            = var.transit_hub_palo_lb_rules_backend_port
      load_distribution       = var.transit_hub_palo_lb_rules_load_distribution
      idle_timeout_in_minutes = var.transit_hub_palo_lb_rules_idle_timeout_in_minutes
      request_path            = "/"
    }
  }
  lb_tags = local.transit_hub_ingress_egress_tags
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

