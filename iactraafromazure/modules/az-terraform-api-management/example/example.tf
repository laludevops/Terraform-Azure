locals {
# For naming convention purpose
    naming_convention_info = {
        name          = "apim"
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

module "apim" {
    source = "../"
  
    naming_convention_info = local.naming_convention_info

## tags to be used with naming convention, anything added here will be added to postgres sql tag
    tags = {
        custom_tag = "Custom tag as needed"
    }

    resource_group_name = local.resource_group_name
    location            = local.location
    publisher_name      = "company"
    publisher_email     = "company@terraform.io"
    sku_name            = "Developer_1"

    certificate = null #[{
    #     encoded_certificate  = ""
    #     certificate_password = ""
    #     store_name           = ""
    # }]

    additional_location = null #[{
    #     location = ""
    # }]

    policy = {
        xml_content = <<XML
        <policies>
        <inbound />
        <backend />
        <outbound />
        <on-error />
        </policies>
        XML
        xml_link = null
        
    }


## used to create diagnostic setting resource
    diag_object = {
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
        log = [["AllLogs", true, true, 80],]
        metric = [["AllMetrics", true, true, 80], ]
    }
}

output "apim" {
  description = "List of apim"
  value = module.apim.apim_list
}

output "diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.apim.diagnostic_log
}