# For naming convention purpose
locals {
  naming_convention_info = {
    name          = "postgresql"
    agency_code   = "iras"
    project_code  = "irasgcc" 
    env           = "dev" 
    zone          = "z1"
    tier          = "web"
  }

  resource_group_name = "rg-alex-iac"
  location            = "southeastasia"
}

module "pip_example" {
  source = "../"
  resource_group_name = local.resource_group_name
  location = local.location
  naming_convention_info = local.naming_convention_info
  tags = {}
}