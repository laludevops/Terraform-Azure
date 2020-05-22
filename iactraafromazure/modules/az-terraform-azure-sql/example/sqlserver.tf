locals {
  resource_group_name = "rg-alex-iac"
  location = "southeastasia"
  naming_convention_info = {
              name            = "eg"
              project_code    = "irasgcc" 
              env             = "dev" 
              zone            = "z1"
              agency_code     = "iras"
              tier            = "web"          
  }
  tags = {}
} 


## data used to pull id of log analytics workspace
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name 
}

data "azurerm_subnet" "subnet_sample1" {
  name                 = "Alex_subnet"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

data "azurerm_subnet" "subnet_sample2" {
  name                 = "postgres_subnet"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

module "sql_example" {
    source                = "../"
    resource_group_name   = local.resource_group_name
    location              = local.location

## list to be used for vnet rule (optional) if not required either remove for put as {}
    vnet_rules = {}
    # {
    #   vnetrule1 = {
    #     subnet_id = data.azurerm_subnet.subnet_sample1.id
    #   }
    #   vnetrule2 = {
    #     subnet_id = data.azurerm_subnet.subnet_sample2.id
    #   }
    # }
##  list to be used for firewall rule (optional) if not required either remove for put as {}
    firewall_rules = {}
    # {
    #   firewallrule1 = {
    #     start_ipaddress = "1.0.0.0"
    #     end_ipaddress   = "1.1.0.0"
    #   }
    #   firewallrule2 = {
    #     start_ipaddress = "2.0.0.0"
    #     end_ipaddress   = "2.2.0.0"
    #   }
    # }

    databases = {
      database_1 = {
        name                             = "AzureDevOps_Configuration"
        collation                        = "SQL_LATIN1_GENERAL_CP1_CI_AS"
        edition                          = "Standard"
        requested_service_objective_name = "S4"
        max_size_bytes                   = "268435456000"
      }
    }
    diag_object          = { 
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
        log  = [["AllLogs", true, true, 80], ]
         metric = [["AllMetrics", true, true, 80], ]
    }
    naming_convention_info    = local.naming_convention_info
    tags                      = local.tags
}