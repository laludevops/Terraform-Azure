locals {
  project_code  = "irasgcc" 
  env           = "test" 
  zone          =  "z2"
  agency_code   = "iras"
  tier          =  "web"
}
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z4-web-lz-001"
  resource_group_name = "rg-lz-iac"
}

locals {
  resource_group_name = "rg-lz-iac"
  location = "southeastasia"
  naming_convention_info = {
              "name"             = "sd"
              "agency_code"  =  local.project_code
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = {}
} 

data "azurerm_client_config" "current" {}


module "akv_example" {
    source                = "../"
    resource_group_name   = local.resource_group_name
    location              = local.location
    sku                   = "premium"
    akv_policies = {
      sp1 = {
        object_id =  data.azurerm_client_config.current.object_id
        tenant_id =  data.azurerm_client_config.current.tenant_id
        key_permissions = ["create", "get", "delete", "update"]
        secret_permissions = ["get", "list", "set"]
      }
    }
    network_acls = [
      {
        bypass          = "AzureServices"
        default_action  = "Allow"
        ip_rules        = null
        subnet_ids      = null
      }
    ]
    
    akv_features = {
      enable_disk_encryption = true
      enable_deployment = true
      enable_template_deployment = true
    }

    diag_object          = { 
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
        log  = [
          ["AllLogs", true, true, 80],
        ]
         metric = [
          ["AllMetrics", true, true, 80],
        ]
    }
    naming_convention_info    = local.naming_convention_info
    tags                      = local.tags
}


output "id" {
  value = module.akv_example.akv_output
}

