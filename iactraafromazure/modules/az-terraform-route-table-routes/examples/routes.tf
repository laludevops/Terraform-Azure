locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "web"
}


locals {
  resource_group_name = "rg-sri-iac"
  location = "southeastasia"
  naming_convention_info = {
              "name"             = "tf"
              agency_code   = local.agency_code
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
    routes            = null
    naming_convention_info    = local.naming_convention_info
    tags                      = local.tags
}


output "rt_obj" {
  value = module.routes_example.rt_output
}
