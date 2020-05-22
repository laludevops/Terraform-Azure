
/*
Prerq:
1. resource group 
2. Log analytics workspace
*/

locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "web"
}


locals {
    resource_group_name = "rg-sri-adtl-vnet"
    naming_convention_info = {
              "name"             = "example"
              "project_code"     =  local.project_code
              "env"              =  local.env
              "zone"             =  local.zone
               tier              =  local.tier
    }
     tags = {
        "Agency-Code"     = local.agency_code
        "project-Code"    = local.project_code
        "environemnt"     = local.env
        "zone"            = local.zone
    }
    log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-sri-adtl-vnet/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-dev-001"
    diag_object = {
      nsg = {
        resource_id = "abc" 
        log = null
        metric = [
                #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period(days)]                 
                  ["AllMetrics", true, true, 80],
        ]
      }
    }
}
module "diagnostics_nsg" {
  source  = "../"

  log_analytics_workspace_id      = local.log_analytics_workspace_id
  diag_object                     = local.diag_object
  naming_convention_info          = local.naming_convention_info
  resource_type                   = "example" 
  tags                            = local.tags
}
