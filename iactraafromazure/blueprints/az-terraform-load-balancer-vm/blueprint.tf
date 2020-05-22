module "virtual_machines" {
  source                          = "../../modules/az-terraform-vm"
  location                        = var.vm_location
  resource_group_name             = var.vm_resource_group_name
  instance_count                  = var.vm_instance_count
  image                           = var.vm_image
  os_type                         = var.vm_os_type
  nic_info                        = var.vm_nic_info
  nic_ids                         = var.vm_nic_ids
  vm_size                         = var.vm_size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  naming_convention_info          = var.vm_naming_convention_info
  diag_object                     = var.vm_diag_object
  tags                            = var.vm_tags
  disk_encryption_info            = var.vm_disk_encryption_info
  disable_password_authentication = var.vm_disable_password_authentication
  marketplace                     = var.vm_marketplace
  dependencies                    = var.dependencies
}

module "load_balancer" {
  source                 = "../../modules/az-terraform-network-load-balancer"
  location               = var.lb_location
  resource_group_name    = var.lb_resource_group_name
  subnet_id              = var.lb_subnet_id
  public_ip_address_id   = var.lb_public_ip_address_id
  sku                    = var.lb_sku
  lb_rules               = var.lb_rules
  diag_object            = var.lb_diag_object
  naming_convention_info = var.lb_naming_convention_info
  tags                   = var.lb_tags
}


locals {
  nic_lb_association = var.vm_nic_info != null ? { for k in range(var.vm_instance_count) : "${k}" => { index = k } } : {}
  existing_nic_lb_association = var.nic_lb_association == null ? {} : {
    for k, v in var.nic_lb_association : "${k}" => v
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_obj" {
  for_each                = local.nic_lb_association
  network_interface_id    = module.virtual_machines.vm_nic_output[each.value.index].id
  ip_configuration_name   = module.virtual_machines.vm_nic_output[each.value.index].ip_configuration[0].name
  backend_address_pool_id = module.load_balancer.azurerm_lb_backend_address_pool_output.id
  depends_on              = [module.virtual_machines, module.load_balancer]
}

resource "azurerm_network_interface_backend_address_pool_association" "existing_nic_lb_obj" {
  for_each                = local.existing_nic_lb_association
  network_interface_id    = each.value.nic_id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = module.load_balancer.azurerm_lb_backend_address_pool_output.id
  depends_on              = [module.virtual_machines, module.load_balancer]
}

