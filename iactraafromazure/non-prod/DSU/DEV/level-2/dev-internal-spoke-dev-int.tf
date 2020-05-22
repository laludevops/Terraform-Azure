locals {
# For naming convention purpose
  dev_intranet_apim_naming_convention_info = {
    name          = var.dev_intranet_apim_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.intranet_zone_name
    tier          = var.cache_tier_name
  }
}

module "dev_intranet_apim" {
    source = "../../../../modules/az-terraform-api-management"
  
    naming_convention_info = local.dev_intranet_apim_naming_convention_info
    tags = var.dev_intranet_apim_tags

    resource_group_name = var.dev_intranet_apim_resource_group_name
    location            = var.dev_intranet_apim_location
    publisher_name      = var.dev_intranet_apim_publisher_name
    publisher_email     = var.dev_intranet_apim_publisher_email
    sku_name            = var.dev_intranet_apim_sku_name

    certificate = var.dev_intranet_apim_certificate

    additional_location = var.dev_intranet_apim_additional_location

    policy = var.dev_intranet_apim_policy
    diag_object = var.dev_intranet_apim_diag_object
}

