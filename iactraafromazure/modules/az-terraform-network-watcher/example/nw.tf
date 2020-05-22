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

module "net_watch_example" {
    source  = "../"
    resource_group_name         = local.resource_group_name
    location                    = local.location
    naming_convention_info      = local.naming_convention_info
    tags                        = local.tags
}