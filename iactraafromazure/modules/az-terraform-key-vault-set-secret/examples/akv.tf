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
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = {}
} 

module "akv_example" {
    source                = "../"
    key_vault_secrets     = {
      {
        key = "test"
        value = "abc"
      }
    }
    naming_convention_info    = local.naming_convention_info
    tags                      = local.tags
}