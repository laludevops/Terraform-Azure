
/*
Prerq:
1. resource group 
2. Log analytics workspace
*/

locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "web"

  loga_workspace_name      = "loga-irasgcc-dev-z1-web-alex-001"
  loga_resource_group_name = "rg-alex-iac"

}


locals {
  resource_group_name = "rg-sri-adtl-vnet"
  naming_convention_info = {
    "project_code" = local.project_code
    "agency_code"  = local.agency_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags = {
    "Agency-Code"  = local.agency_code
    "project-Code" = local.project_code
    "environemnt"  = local.env
    "zone"         = local.zone
  }
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loga_obj.id
  diag_object = {

    kv = {
      resource_id = [
        "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/security-vnet-rg/providers/Microsoft.Network/loadBalancers/LB-abcdefg"
        # "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
      ]
      log = [
        // ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period(days)]                 
        ["LoadBalancerAlertEvent", true, true, 80],
        ["LoadBalancerProbeHealthStatus", true, true, 80],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period(days)]                 
        ["AllMetrics", true, true, 80],
      ]
    }
  }
}

data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = local.loga_workspace_name
  resource_group_name = local.loga_resource_group_name
}


module "diagnostics_nsg" {
  source = "../"

  log_analytics_workspace_id = local.log_analytics_workspace_id
  diag_object                = local.diag_object
  naming_convention_info     = local.naming_convention_info
  resource_type              = "example"
  tags                       = local.tags
}



output "diag_obj" {
  value = module.diagnostics_nsg.diag_object
}
