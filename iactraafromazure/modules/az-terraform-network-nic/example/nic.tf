locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "web"
}


locals {
  resource_group_name = "rg-sri-iac"
  vnet_name           = "vnet-iac-sri"
  location            = "southeastasia"
  naming_convention_info = {
    "name"         = "sri"
    "agency_code"  = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags = {}
}


data "azurerm_subnet" "example" {
  name                 = "snet-irasgcc-devz1web-s1"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.resource_group_name
}




# data "azurerm_network_security_group" "example" {
#   name                = "nsg-irasgcc-dev-s1"
#   resource_group_name = local.resource_group_name
# }


module "nic_obj" {
  source              = "../"
  location            = local.location
  resource_group_name = local.resource_group_name
  nsg_id              = null
  instance_count      = 2
  subnet_id           = data.azurerm_subnet.example.id
  nic_info = {
    n1 = {
      is_primary           = true
      public_ip_address_id = null
      private_ip_address   = null
    }
    n2 = {
      is_primary           = false
      public_ip_address_id = null
      private_ip_address   = null
    }
  }
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}

output "test" {
  value = module.nic_obj.nic_output
}


