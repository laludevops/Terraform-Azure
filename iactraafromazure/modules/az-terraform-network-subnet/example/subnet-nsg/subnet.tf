/*
Prerequisite:
1. Resource group -- manual
2. vnet -- SR
3. LAW -- TF
*/
locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
}

#change these parameters for testing in your env
locals {
  virtual_network_name                = "vnet-iac-sri"
  virtual_network_resource_group_name = "rg-sri-iac"
  loga_workspace_name = "loga-irasgcc-dev-z4-web-lz-001"
  loga_resource_group_name = "rg-lz-iac"
}


module "nw_storage_example" {
    source                = "../../../az-terraform-storage-account"
    resource_group_name   = local.virtual_network_resource_group_name
    location              = local.location
    kind                  = "StorageV2"
    sku                   = "Standard_LRS"
    access_tier           = "Hot"
    assign_identity       = true
    diag_object         = null
    naming_convention_info    = merge(local.naming_convention_info, {"name" = "nw"})
    tags                      = local.tags
}


data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = local.loga_workspace_name
  resource_group_name = local.loga_resource_group_name
}

locals {
  location = "southeastasia"
  naming_convention_info = {
              "agency_code"  =  local.agency_code
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = "web"
    }
  tags = {}
  diag_object = { 
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loga_obj.id
              log  = [
                # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
                ["NetworkSecurityGroupRuleCounter", true, true, 80],
                ["NetworkSecurityGroupEvent", true, true, 80],
      ]
        metric = []
    }
} 

module "routes_example" {
    source                = "../../../az-terraform-route-table-routes"
    resource_group_name   = local.virtual_network_resource_group_name
    location              = local.location
    routes            = null
    naming_convention_info    = merge(local.naming_convention_info, {name = "eg" })
    tags                      = local.tags
}


# # Create a Subnet inside the VNet
module "subnet_poc_test" {
  source = "../../"
  resource_group_name = local.virtual_network_resource_group_name
  virtual_network_name = local.virtual_network_name
  location = local.location
  naming_convention_info = local.naming_convention_info
  tags = local.tags
  subnets = {
    s3 = {
            cidr                = "10.12.3.0/24"
            service_endpoints   = []
            route_table_id      = module.routes_example.rt_output.id
            create_nsg          = true
            nsg_inbound = [["LDAP-t", "100", "Inbound", "Allow", "*", "*", "389", "*", "*"]]
            nsg_outbound = []
            delegation          = null
    }
  }
  diag_object = local.diag_object

  netwatcher = {
    network_watcher_name = "NetworkWatcher_southeastasia"
    resource_group_name  = "NetworkWatcherRG"
    storage_account_id = module.nw_storage_example.sst_output.id
    retention_period_days = 7
      law = {
        id = data.azurerm_log_analytics_workspace.loga_obj.id
        location = local.location
        workspace_id = data.azurerm_log_analytics_workspace.loga_obj.workspace_id
      }
  }
}

output "subnet_nsg_output" {
  value = module.subnet_poc_test.snet_nsg_output
}


