locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "web"
}


locals {
  resource_group_name = "rg-sri-adtl-vnet"
  location = "southeastasia"
  naming_convention_info = {
              "name"             = "tf"
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = {}
} 

module "routes_example" {
    source                = "../"
    resource_group_name   = local.resource_group_name
    location              = local.location
    routes            = {
      route1 = {
        destination_CIDR       = ""
        next_hop_in_ip_address = ""
        next_hop_in_ip_address = ""
      }
    }
    diag_object          = { 
        log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-sri-adtl-vnet/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-dev-001"
        log  = null
         metric = [
          ["AllMetrics", true, true, 80],

        ]
    }
    naming_convention_info    = local.naming_convention_info
    tags                      = local.tags
}


output "rt_obj" {
  value = module.routes_example.rt_object
}
