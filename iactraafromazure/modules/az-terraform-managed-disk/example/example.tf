locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "web"
}


locals {
  resource_group_name = "v2-rg-managed_disk_iac"
  vnet_name           = "v2-vnet-managed_disk_iac"
  location            = "southeastasia"
  naming_convention_info = {
    "name"         = "vin"
    "agency_code"  = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags = {}
}

module "disk_obj" {
  source                 = "../"
  location               = local.location
  resource_group_name    = local.resource_group_name
  instance_count         = 2
  storage_account_type   = "Standard_LRS"
  create_option          = "Empty"
  disk_size_gb           = "1"
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  keyvault_id            = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
  enable_disk_encryption = "true"
}



