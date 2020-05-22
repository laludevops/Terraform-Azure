data "azurerm_shared_image_version" "tosca_server_gallery_image" {
  name                = var.tosca_server_gallery_image_version             //"1.0.3"
  image_name          = var.tosca_server_gallery_image_name                //"windowsdevmachine01"
  gallery_name        = var.tosca_server_gallery_name                      //"irasdev_sharedimagegallery"
  resource_group_name = var.tosca_server_gallery_image_resource_group_name //"rg-secteam-roniel"
}

module "tosca_server_with_load_balancer" {
  source                             = "../../blueprints/az-terraform-load-balancer-vm"
  vm_location                        = var.common_devops_tosca_server_location
  vm_resource_group_name             = var.common_devops_tosca_serverresource_group_name
  vm_instance_count                  = var.common_devops_tosca_server_lb_instance_count
  vm_size                            = var.common_devops_tosca_server_vm_size
  vm_admin_username                  = var.common_devops_tosca_server_admin_username
  vm_admin_password                  = var.common_devops_tosca_server_admin_password
  vm_naming_convention_info          = merge(local.devops_zone_app_tier_naming_convention_info, { name = var.common_devops_tosca_server_name })
  vm_tags                            = merge(local.devops_zone_app_tier_tags, {})
  vm_disable_password_authentication = true
  disk_encryption_info               = var.common_devops_tosca_server_disk_encryption_info
  vm_diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  vm_disk_encryption_info = null
  vm_nic_info = {
    subnet_id          = data.terraform_remote_state.common_level_1.devops_app_tier_info.id
    nsg_id             = data.terraform_remote_state.common_level_1.devops_app_tier_info.nsg_id
    private_ip_address = null
  }
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
