locals {
# For naming convention purpose
    naming_convention_info = {
        name          = "redis"
        agency_code   = "iras"
        project_code  = "irasgcc" 
        env           = "dev" 
        zone          = "z1"
        tier          = "web"
    }   
    resource_group_name = "rg-alex-iac"
    location            = "southeastasia"
}

## data used to pull id of log analytics workspace
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name 
}


data "azurerm_subnet" "subnet" {
    name                    = "cosmosdb_subnet"
    virtual_network_name    = "Alex_vnet"
    resource_group_name     = local.resource_group_name
}

module "cosmosdb" {
    source = "../"
  
    naming_convention_info = local.naming_convention_info

## tags to be used with naming convention
    tags = {
      "custom_tag" = "Custom tag as needed"
    }

    location = local.location
    resource_group_name = local.resource_group_name 

##  Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard. (required)
    offer_type          = "Standard"

##  Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB. 
##  Defaults to GlobalDocumentDB. Changing this forces a new resource to be created. 
    kind                = "GlobalDocumentDB"

##  This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. 
##  IP addresses/ranges must be comma separated and must not contain any spaces. currently the only range available to set is /30 or /32
##  (optional) if not required either remove or put variable as null
    ip_range_filter     = "1.1.1.1,2.2.2.2"

##  Enable automatic fail over for this Cosmos DB account.
    enable_automatic_failover = false

##  The capabilities which should be enabled for this Cosmos DB account. 
##  Possible values are EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableTable, MongoDBv3.4, and mongoEnableDocLevelTTL.
##  (optional) if not required either remove or put block as null
    capabilities = null
    # {
    #     name = "EnableAggregationPipeline"
    # }

##  Enables virtual network filtering for this Cosmos DB account. (optional) if not required either remove or put variable as null
    is_virtual_network_filter_enabled = true
    
##  Enable multi-master support for this Cosmos DB account. (optional) if not required either remove or put variable as null
    enable_multiple_write_locations = false

##  to define the consistency policy for this CosmosDB account. (required)
    consistency_policy = {
            consistency_level       = "BoundedStaleness"
            max_interval_in_seconds = 10
            max_staleness_prefix    = 200
    }
##  used to define where data should be replicated with the failover_priority 0 specifying the primary location. (required)
    geo_location = [
        # {
        #     prefix            = null
        #     location          = local.location
        #     failover_priority = 1
        # },
        {
            prefix            = null #"name-customid"
            location          = local.location
            failover_priority = 0
        }
    ]

##  to assign a subnet for cosmosdb, note that the subnet must be assigned with ServiceEndpoint of Microsoft.AzureCosmosDB 
##  (optional) if not required either remove or put block as null
    virtual_network_rule = [
        {
            id = data.azurerm_subnet.subnet.id
        }
    ]

    ## used to create diagnostic setting resource
    diag_object = {
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
        log = [["AllLogs", true, true, 80],]
        metric = [["AllMetrics", true, true, 80], ]
    }

}

output "azurerm_cosmosdb_account" {
  description = "azurerm_cosmosdb_account"
  value = module.cosmosdb.azurerm_cosmosdb_account
}

output "diagnostic_log" {
  description = "diagnostic_log"
  value = module.cosmosdb.diagnostic_log
}