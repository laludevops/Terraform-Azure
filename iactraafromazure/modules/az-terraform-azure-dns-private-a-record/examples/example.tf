locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "web"
}


locals {
  resource_group_name = "rg-sri-iac"
  location            = "southeastasia"
  naming_convention_info = {
    agency_code    = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags = {}
}


module "private_dns_example" {
  source                 = "../"
  resource_group_name    = "rg-sri-iac"
  dns_zone_name          = "irasgcc.gov.sg"
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  a_records = {
    "iras-private-dns" = {
      a_record_name = "test"
      ips           = ["10.4.1.4"]
      ttl           = 300
    }
  }
}
