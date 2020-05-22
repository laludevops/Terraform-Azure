locals {
  # For naming convention purpose
  dev_internet_asp_naming_convention_info = {
    name          = var.dev_internet_app_asp_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.internet_zone_name
    tier          = var.cache_tier_name
  }

  dev_internet_ase_naming_convention_info = {
    name          = var.dev_internet_app_ase_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.internet_zone_name
    tier          = var.cache_tier_name
  }

}

module "dev_internet_asp_linux" {
  source              = "../../../../modules/az-terraform-app-service-plan-linux"
  resource_group_name = var.dev_internet_app_asp_resource_group_name
  location            = var.dev_internet_app_asp_location
  ase_id              = module.dev_internet_ase.id
  max_worker_count    = var.dev_internet_app_asp_max_worker_count
  sku                 = var.dev_internet_app_asp_sku
  naming_convention_info = local.dev_internet_asp_naming_convention_info
  tags                   = var.dev_internet_app_asp_tags
}

module "dev_internet_ase" {
  source                    = "../../../../modules/az-terraform-arm-ase"
  naming_convention_info    = local.dev_internet_ase_naming_convention_info
  resource_group_name       = var.dev_internet_app_ase_resource_group_name
  location                  = var.dev_internet_app_ase_location
  kind                      = var.dev_internet_app_ase_kind
  vnet_id                   = var.dev_internet_app_ase_vnet_id
  subnet_name               = var.dev_internet_app_ase_subnet_name
  internalLoadBalancingMode = var.dev_internet_app_ase_internalLoadBalancingMode
  tags                      = var.dev_internet_app_ase_tags
}