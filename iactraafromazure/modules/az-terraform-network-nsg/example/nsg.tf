
/*
Prerequisites:
1. rg
2. vnet
3. LAW
4. Network watcher
5. storage accont for nsg flow logs
*/

locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "web"
}


locals {
  #specify your vnet name
  virtual_network_name                = "vnet-iac-sri"
  #specify your vnet name resource group nae
  resource_group_name = "rg-sri-iac"
  location = "southeastasia"
  naming_convention_info = {
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = { }
  network_watcher_storage_account_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-sri-iac/providers/Microsoft.Storage/storageAccounts/sstirasgccdevz1webnw001"
  loga_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-sri-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-sri-001"
  loga_workspace_id = "9cb38752-c2e9-4f60-98a3-fad04a5b5fc1"
  
} 

module "nsg_example" {
    source = "../"
    resource_group_name = local.resource_group_name
    location = local.location
    nsg_info = {
      nsg1 = {
        nsg_inbound = [["LDAP-t", "100", "Inbound", "Allow", "*", "*", "389", "*", "*"]]
        nsg_outbound = []
      }
      nsg2 = {
        nsg_inbound = [["LDAP-t", "100", "Inbound", "Allow", "*", "*", "389", "*", "*"]]
        nsg_outbound = []
      }
     
    }
    diag_object = { 
      log_analytics_workspace_id = local.loga_id
      log  = [
                # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
                ["AllLogs", true, true, 80],
      ]
      metric = [
      ]
    }
    naming_convention_info = local.naming_convention_info
    tags = local.tags

  # netwatcher = {
  #   network_watcher_name = "NetworkWatcher_southeastasia"
  #   resource_group_name  = "NetworkWatcherRG"
  #   storage_account_id = local.network_watcher_storage_account_id
  #   retention_period_days = 7
  #     law = {
  #       id = local.loga_id
  #       location = local.location
  #       workspace_id = local.loga_workspace_id
  #     }
  # }
}

output "nsg_id" {
  value = module.nsg_example.nsg_output
}
