
    dev_intranet_apim_tags = {
        custom_tag = "Custom tag as needed"
    }
    dev_intranet_apim_name                = "apim"
    dev_intranet_apim_resource_group_name = "rg-alex-iac"
    dev_intranet_apim_location            = "southeastasia"
    dev_intranet_apim_publisher_name      = "company"
    dev_intranet_apim_publisher_email     = "company@terraform.io"
    dev_intranet_apim_sku_name            = "Developer_1"
    dev_intranet_apim_certificate = null
    dev_intranet_apim_additional_location = null
    dev_intranet_apim_policy = {
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
    dev_intranet_apim_diag_object = {
        log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-alex-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-alex-001"
        log = [["AllLogs", true, true, 80],]
        metric = [["AllMetrics", true, true, 80], ]
    }
