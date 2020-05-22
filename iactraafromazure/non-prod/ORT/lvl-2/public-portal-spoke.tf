locals {
  public_portal_naming_convention_info = merge(local.landing_zone_naming_convention, {
    zone = var.internet_zone_name
    tier = var.gut_tier_name
  })
  public_portal_tags = merge(local.landing_zone_tags, {})
}

module "public_portal_forward_proxy_asg" {
  source                 = "../../../modules/az-terraform-network-asg"
  location               = var.location
  resource_group_name    = var.public_portal_asg_resource_group_name
  naming_convention_info = merge(local.public_portal_naming_convention_info, { name = var.public_portal_forward_proxy_name })
  tags                   = merge(local.landing_zone_tags, {})
}

# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "public_portal_forward_proxyasg_nic_obj" {
  count                         = var.public_portal_forward_proxy_vm_instance_count
  network_interface_id          = module.public_portal_forward_proxy_with_lb.vm_with_load_balancer_output.nic[count.index].id
  application_security_group_id = module.public_portal_forward_proxy_asg.asg_output.id
  ip_configuration_name         = module.public_portal_forward_proxy_with_lb.vm_with_load_balancer_output.nic[count.index].ip_configuration[0].name
  depends_on                    = [module.public_portal_forward_proxy_with_lb, module.public_portal_forward_proxy_asg]
}

//Create Palo Alto vms with lb 
module "public_portal_forward_proxy_with_lb" {
  source                             = "../../../blueprints/az-terraform-load-balancer-vm"
  vm_location                        = var.location
  vm_resource_group_name             = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "public_portal_forward_proxy_vm_resource_group_name"), "name")
  vm_instance_count                  = var.public_portal_forward_proxy_vm_instance_count
  vm_size                            = var.public_portal_forward_proxy_vm_size
  vm_admin_username                  = var.public_portal_forward_proxy_vm_admin_username
  vm_admin_password                  = var.public_portal_forward_proxy_vm_admin_password
  vm_naming_convention_info          = merge(local.public_portal_naming_convention_info, { name = var.public_portal_forward_proxy_name })
  vm_tags                            = local.public_portal_tags
  vm_os_type                         = var.public_portal_forward_proxy_vm_os_type
  vm_disable_password_authentication = true
  vm_image = {
    publisher = var.public_portal_forward_proxy_vm_image_publisher
    offer     = var.public_portal_forward_proxy_vm_image_offer
    sku       = var.public_portal_forward_proxy_vm_image_sku
    version   = var.public_portal_forward_proxy_vm_image_version
  }
  vm_marketplace = {
    name      = var.public_portal_forward_proxy_vm_marketplace_name
    publisher = var.public_portal_forward_proxy_vm_marketplace_publisher
    product   = var.public_portal_forward_proxy_vm_marketplace_product
  }
  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  vm_disk_encryption_info = null
  vm_nic_info = {
    subnet_id = data.terraform_remote_state.ort_level_1.outputs.ort_public_portal_gut_0002_tier_info.id
    nsg_id    = null
    nics = {
      "${var.public_portal_forward_proxy_name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  lb_resource_group_name    = lookup(lookup(module.ort_level_2_resource_groups.rg_output, "public_portal_forward_proxy_vm_resource_group_name"), "name")
  lb_location               = var.location
  lb_static_ip              = "10.192.120.140"
  lb_subnet_id              = data.terraform_remote_state.ort_level_1.outputs.ort_public_portal_gut_0002_tier_info.id
  lb_naming_convention_info = merge(local.public_portal_naming_convention_info, { name = var.public_portal_forward_proxy_name })
  lb_sku                    = var.public_portal_forward_proxy_with_lb_sku
  lb_rules = {
    rule_one = {
      probe_port              = var.public_portal_forward_proxy_with_lb_rules_probe_port
      probe_protocol          = var.public_portal_forward_proxy_with_lb_rules_probe_protocol
      lb_port                 = var.public_portal_forward_proxy_with_lb_rules_lb_port
      backend_port            = var.public_portal_forward_proxy_with_lb_rules_backend_port
      load_distribution       = var.public_portal_forward_proxy_with_lb_rules_load_distribution
      idle_timeout_in_minutes = var.public_portal_forward_proxy_with_lb_rules_idle_timeout_in_minutes
      request_path            = "/"
    }
  }
  dependencies = [module.ort_level_2_resource_groups]
  lb_tags      = merge(local.landing_zone_tags, {})
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
