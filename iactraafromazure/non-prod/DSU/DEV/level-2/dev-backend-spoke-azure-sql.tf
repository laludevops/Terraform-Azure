locals {
  # For naming convention purpose
  dev_backend_azsql_naming_convention_info = {
    name         = var.dev_backend_azsql_name
    agency_code  = var.agency_code
    project_code = var.project_code
    env          = var.env
    zone         = var.backend_zone_name
    tier         = var.cache_tier_name
  }
}

module "dev_backend_azsql_sql" {
  source                 = "../../../../modules/az-terraform-azure-sql"
  resource_group_name    = var.dev_backend_azsql_resource_group_name
  location               = var.dev_backend_azsql_location
  vnet_rules             = var.dev_backend_azsql_vnet_rules
  firewall_rules         = var.dev_backend_azsql_firewall_rules
  databases              = var.dev_backend_azsql_databases
  diag_object            = var.dev_backend_azsql_diag_object
  naming_convention_info = local.dev_backend_azsql_naming_convention_info
  tags                   = var.dev_backend_azsql_tags
}
