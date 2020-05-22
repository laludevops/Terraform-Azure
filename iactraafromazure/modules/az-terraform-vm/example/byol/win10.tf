locals {
  project_code = "iras"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "we"
}


locals {
  resource_group_name = "rg-sri-iac"
  vnet_name           = "vnet-sri"
  location            = "southeastasia"
  naming_convention_info = {
    start_index    = 3
    "name"         = "bl"
    "agency_code"  = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags     = {}
  vm_count = 3
  loga_id  = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-lz-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-mad-001"
}


data "azurerm_subnet" "example" {
  name                 = "snet-irasgcc-devz1web-s1"
  virtual_network_name = "vnet-iac-sri"
  resource_group_name  = local.resource_group_name
}

module "asg_example" {
  source                 = "../../../az-terraform-network-asg"
  location               = local.location
  resource_group_name    = local.resource_group_name
  naming_convention_info = local.naming_convention_info
  tags                   = {}
}

module "virtual_machine" {
  source              = "../../"
  location            = local.location
  resource_group_name = local.resource_group_name
  instance_count      = local.vm_count
  license_type        = "Windows_Client"
  image = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "rs4-pro"
    version   = "latest"
  }
  nic_info = {
    subnet_id = data.azurerm_subnet.example.id
    nsg_id    = null
    nics = {
      "${local.naming_convention_info.name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  vm_size                = "Standard_D4s_v3"
  admin_username         = "admin123"
  admin_password         = "adMin%6541"
  naming_convention_info = local.naming_convention_info
  disk_encryption_info   = null
  tags                   = {}
}


# nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "asg_nic_obj" {
  count                         = local.vm_count
  network_interface_id          = module.virtual_machine.vm_nic_output[count.index].id
  application_security_group_id = module.asg_example.asg_output.id
  ip_configuration_name         = module.virtual_machine.vm_nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.virtual_machine, module.asg_example]
}

