locals {
## The naming convention used for insights
  naming_convention_info = {
    name          = "insight-custom"
    agency_code   = "iras"
    project_code  = "irasgcc" 
    env           = "devops" 
    zone          = "z1"
    tier          = "app"
  }
## resrouce group and location
  resource_group_name = "rg-alex-iac"
  location            = "southeastasia"

}

## data used to pull id of log analyytics workspace
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name 
}

module "insight" {
  source = "../"

  naming_convention_info = local.naming_convention_info

## tags to be used with naming convention
  tags = {
    "custom_tag" = "Custom tag as needed"
  }
  
  resource_group_name   = local.resource_group_name
  location              = local.location
## application type for insights to create, valid values are: ios, java, MobileCenter, Node.JS, other, phone, store and web
  application_type      = "web"


## the list of api key to be created, 3 permissions can be given (if write or read permission is empty, leave it as []):
## write annotations: to enable add "annotations" in write_permissions list
## read telementry: to enable add "aggregate", "api", "draft", "extendqueries", "search" in read_permissions list
## authenticate sdk control channel: to enable add "agentconfig" in read_permissions list
  api_permissions = {
    full = {
      read_permissions  = ["agentconfig", "aggregate", "api", "draft", "extendqueries", "search"]
      write_permissions = ["annotations"]
    }
    sdk = {
      read_permissions  = ["agentconfig"]
      write_permissions = []
    }
    read = {
      read_permissions  = ["aggregate", "api", "draft", "extendqueries", "search"]
      write_permissions = []
    }
    write = {
      read_permissions  = []
      write_permissions = ["annotations"]
    }
  }

}

output "api_key" {
  description = "List of api key value"
  value = module.insight.api_key
}

output "azure_insight" {
  description = "List of api key value"
  value = module.insight.azure_insight
}
