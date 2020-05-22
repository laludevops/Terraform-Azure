locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "web"
}


locals {
  virtual_network_name                = "vnet-sri"
  resource_group_name                 = "rg-lz-iac"
  naming_convention_info = {
              "name"             = "example"
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = {}
  loga_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-lz-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-mad-001"
} 

data "azurerm_subnet" "subnet_example" {
  name                 = "sub-irasgcc-dev-z1-web-s1-001"
  virtual_network_name = local.virtual_network_name
  resource_group_name  = local.resource_group_name
}

module "acr_example" {
    source = "../"
    resource_group_name = local.resource_group_name
    location = "southeastasia"
    sku = "Premium"
    
    diag_object = { 
      log_analytics_workspace_id = local.loga_id
      log  = [
                ["AllLogs", true, true, 80],
      ]
      metric = [
          ["AllMetrics", true, true, 80 ],
      ]
    }

    vnet_rule =    [ data.azurerm_subnet.subnet_example.id ]
        #[action(Allow, Deny), subnet_id]
     
    
    naming_convention_info = local.naming_convention_info
    tags = local.tags

 }