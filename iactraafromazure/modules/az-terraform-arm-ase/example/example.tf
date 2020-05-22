locals {
  naming_convention_info = {
    name         = "iso"
    agency_code  = "iras"
    project_code = "irasgcc"
    env          = "devops"
    zone         = "z1"
    tier         = "app"
  }
  resource_group_name = "rg-iac-lz2-common" 
  location            = "southeastasia"
  loga_id = data.azurerm_log_analytics_workspace.log_example.id
}

data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z4-web-lz-001"
  resource_group_name = "rg-lz-iac"
}

data "azurerm_subnet" "example" {
  name                 = "default"
  virtual_network_name = "vnet-ase"
  resource_group_name  = local.resource_group_name
}

module "ase_example" {
  source                    = "../"
  naming_convention_info    = local.naming_convention_info
  resource_group_name       = local.resource_group_name
  location                  = local.location
  kind                      = "ASEV2"
  vnet_id                   = data.azurerm_subnet.example.id
  subnet_name               = "default"
  internalLoadBalancingMode = 3 //internal
  tags                      = {}
   diag_object          = { 
      log_analytics_workspace_id = local.loga_id
        log  = [
          ["AppServiceEnvironmentPlatformLogs", true, true, 80],
        ]
         metric = [
        ]
    }
}
