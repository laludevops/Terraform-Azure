locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "web"
}


locals {
  resource_group_name = "rg-sri-iac"
  vnet_name           = "vnet-sri-iac"
  location = "southeastasia"
  naming_convention_info = {
              "name"             = "ubu"
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = {}
  loga_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-sri-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-sri-001"
} 

data "azurerm_subnet" "example" {
  name                 = "sub-irasgcc-dev-z1-web-s1-001"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.resource_group_name
}

data "azurerm_network_security_group" "example" {
  name                = "nsg-irasgcc-dev-z1-web-s1-001"
  resource_group_name = local.resource_group_name
}


module "virtual_machine" {
  source              = "../../"
  location            = local.location
  resource_group_name = local.resource_group_name
  os_type           = "linux"
  instance_count      = 2
  nic_info = {
    subnet_id           = data.azurerm_subnet.example.id
    nsg_id              = data.azurerm_network_security_group.example.id
    private_ip_address  = null
  }
  image               =  null
  marketplace = {
    name = "bundle2"
    publisher = "paloaltonetworks"
    product = "vmseries1"
  }

  vm_size             = "Standard_D4s_v3"
  fqdn                = "example"
  admin_username      = "admin123"
  admin_password      = "adMin%6541"
  naming_convention_info = local.naming_convention_info
  diag_object                     = { 
        log_analytics_workspace_id = local.loga_id
        log  = []
         metric = [
          ["AllMetrics", true, true, 80],
        ]
    }
  tags                = local.tags
}


output "vm_obj" {
  value = module.virtual_machine.vm_output

}