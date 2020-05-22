locals {
# For naming convention purpose
    naming_convention_info = {
        name          = "waf"
        agency_code   = "iras"
        project_code  = "irasgcc" 
        env           = "dev" 
        zone          = "z1"
        tier          = "web"
    }   
    resource_group_name = "rg-alex-iac"
    location            = "southeastasia"
}

data "azurerm_subnet" "frontend" {
  name                 = "frontend"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

data "azurerm_subnet" "backend" {
  name                 = "backend"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

data "azurerm_public_ip" "pubip" {
    name = "alex-ip"
    resource_group_name = local.resource_group_name
}

## data used to pull id of log analytics workspace
data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name 
}

module "waf" {
    source = "../"

    resource_group_name = local.resource_group_name
    location            = local.location
##  zone is optional and only supported by v2 SKUs, if not required please comment it off or put as null
    zone                = null
##  HTTP2 on the application gateway resource, defaults to false
    enable_http2        = false

    # gateway_ip_name                = "-gwipname"
    # backend_address_pool_name      = "-beap"
    # frontend_port_name             = "-feport"
    # frontend_ip_configuration_name = "-feip"
    # http_setting_name              = "-be-htst"
    # listener_name                  = "-httplstn"

    naming_convention_info = local.naming_convention_info

## tags to be used with naming convention, anything added here will be added to postgres sql tag
    tags = {
        custom_tag = "Custom tag as needed"
    }

##  subnet id to be used for gateway_ip_configuration
    gateway_ip_configuration = {
        gateway = {
            subnet_id       = data.azurerm_subnet.frontend.id
        }
    }

##  sku required for application gateway
    sku_name        = "WAF_Medium" 
    sku_tier        = "WAF"
    ## if autoscale_capacity is to be used, sku_capacity have to be null
    sku_capacity    = 1

##  waf_configuration
    waf_enabled                     = true
    waf_firewall_mode               = "Detection"
    waf_rule_set_type               = "OWASP"
    waf_rule_set_version            = "3.0"
    waf_file_upload_limit_mb        = "100"
    waf_request_body_check          = true
    waf_max_request_body_size_kb    = "128"

    disabled_rule_group = [
        {
            ## The rule group where specific rules should be disabled
            rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
            ## list of rules which should be disabled in that group
            rules           = ["931100", "931130"]
        } #,
        # {
        #     rule_group_name = "crs_21_protocol_anomalies"
        #     rules           = null
        # }
    ]

    exclusion = [
        {
            ## Match variable of the exclusion rule to exclude header, cookie or GET arguments. Possible values are RequestHeaderNames, RequestArgNames and RequestCookieNames
            match_variable          = "RequestHeaderNames"
            ## Operator which will be used to search in the variable content. Possible values are Equals, StartsWith, EndsWith, Contains. If empty will exclude all traffic on this match_variable
            selector_match_operator = "Contains"
            ## String value which will be used for the filter operation. If empty will exclude all traffic on this match_variable
            selector                = "testvalue"
        },
        {
            match_variable          = "RequestArgNames"
            selector_match_operator = "EndsWith"
            selector                = "testvalue"
        }

    ]

##  frontend_port
    frontend_port = {
        fep = {
            portno = 80
        }
    }

##  frontend_ip_configuration (if any of the options is not required put as null)

    frontend_ip_configuration = {
        fic = {
            ## (Optional) The ID of a Public IP Address which the Application Gateway should use. 
            public_ip_address_id = null
            ## (Required) The ID of the Subnet which the Application Gateway should be connected to.
            subnet_id = data.azurerm_subnet.frontend.id
            ## (Optional) The Private IP Address to use for the Application Gateway.
            private_ip_address = "10.20.2.4" 
            ##(Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static.
            private_ip_address_allocation = "Static"
        }
    }

##  backend_address_pool
    backend_address_pool = {
        bapn = {
            fqdns       = null
            ipaddresses = null
        }
    }

##  backend_http_settings
    backend_http_settings = {
        settings1 = {
            be_affinity_cookie_name                     = null
            be_http_cookie_based_affinity               = "Disabled"
            be_http_path                                = "/"
            be_http_port                                = 443
            be_http_protocol                            = "Https"
            be_http_request_timeout                     = "1"
            be_probe_name                               = "https-probe"
            be_hostname                                 = null
            be_pick_host_name_from_backend_http_settings   = true

        ##  authentication_certificate inside backend_http_settings (optional) if not required either remove or put block as null
            authentication_certificate = null
            # [{
            #     name = "test-name"
            # }]

        ##  trusted_root_certificate inside backend_http_settings (optional) if not required either remove or put list as null
            be_trusted_root_certificate_name = null# ["a", "b"]

        ##  be_connection_draining inside backend_http_settings (optional) if not required either remove or put block as null
            connection_draining = {
                enabled = true
                drain_timeout_sec = 3600
            }
        }
    }

##  http_listener
    http_listener = {
        httpl = {
            frontend_ip_configuration_name = "fic"
            frontend_port_name = "fep"
            protocol = "Http"
            host_name = "http_host_name"
            ## Should Server Name Indication be Required? Defaults to false
            require_sni = false
            ## name of the associated SSL Certificate which should be used for this HTTP Listener (optional) 
            ## if not required either remove or put block as null
            ssl_certificate_name = null #"httpsslcert"
            ## http custom error config block (optional) if not required either remove or put block as null
            http_custom_error_configuration = null
            # [{
            #     ## Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502
            #     status_code = "HttpStatus502"
            #     ## Error page URL of the application gateway customer error
            #     custom_error_page_url = ""
            # }]
        }
    }

##  request_routing_rule
    request_routing_rule = {
        rrr = {
            http_listener_name = "httpl"
            backend_address_pool_name = "bapn"
            backend_http_settings_name = "settings1"
            rule_type = "basic"
            ## The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs. 
            ## (optional) if not required either remove or put variable as null
            rewrite_rule_set_name = null
            ## The Name of the URL Path Map which should be associated with this Routing Rule. 
            ## (optional) if not required either remove or put variable as null
            url_path_map_name = null
        }
    }

##  identity (optional) if not required either remove or put block as null
    identity = null
    # {
    #   type = "UserAssigned"
    #   identity_ids = [""]
    # }

##  authentication_certificate, not supported if using sku WAF_V2 (optional) if not required either remove or put block as null
    authentication_certificate = null
    # {
    #     data = "test"
    #     name = "test-name"
    # }

##  autoscale_capacity (optional) if not required either remove or put block as null
    autoscale_capacity = null
    # {
    #     autoscale_min_capacity = 0
    #     autoscale_max_capacity = 2
    # }

##  trusted_root_certificate (optional) if not required either remove or put block as null
    trusted_root_certificate = null
    # {
    #     data = filebase64("<filepath>")
    #     name = "test-name"
    # }

##  ssl_policy (optional) if not required either comment it off or put block as null
##  disabled_protocols cannot be set when policy_name or policy_type are set. 
##  policy_type is Required when policy_name is set - cannot be set if disabled_protocols is set.
    ssl_policy = {
        disabled_protocols    = ["TLSv1_0", "TLSv1_1"]
        policy_type           = "Predefined"
        policy_name           = "AppGwSslPolicy20150501"
        cipher_suites         = null #["TLS_DHE_DSS_WITH_AES_128_CBC_SHA", "TLS_DHE_DSS_WITH_AES_128_CBC_SHA256"]
        min_protocol_version  = "TLSv1_2"
    }

##  redirect_configuration
    redirect_configuration = {
      name                  = "redirectname"
      ## The type of redirect. Possible values are Permanent, Temporary, Found and SeeOther
      redirect_type         = "Permanent"
      ## The name of the listener to redirect to. Cannot be set if target_url is set.
      target_listener_name  = null
      ## The Url to redirect the request to. Cannot be set if target_listener_name is set
      target_url            = "https://merlion.azurewebsites.net/home"
      ## Whether or not to include the path in the redirected Url. Defaults to false
      include_path          = false
      ## Whether or not to include the query string in the redirected Url. Default to false
      include_query_string  = false
    }

##  probe
    probe = [
      {
          host = null
          name = "http-probe"
          protocol = "Http"
          path = "/"
          timeout = 30
          interval = 20
          unhealthy_threshold = 10
          pick_host_name_from_backend_http_settings = true
          minimum_servers = 1
          match = null
          },
          {
          host = null
          name = "https-probe"
          protocol = "Https"
          path = "/"
          timeout = 30
          interval = 20
          unhealthy_threshold = 10
          pick_host_name_from_backend_http_settings = true
          minimum_servers = null
          match = null
       }
     ] 

##  rewrite_rule_set
    rewrite_rule_set = null
    # {
    #     name = "name"
        
    #     rewrite_rule = [{
    #         name = "name1"
    #         rule_sequence = 1
    #         request_header_configuration = [{
    #             header_name = "headername"
    #             header_value = "headervalue"
    #         }]
    #         response_header_configuration = [{
    #             header_name = "testheader"
    #             header_value = "test"
    #         }]
    #         condition = [{
    #             ## The variable of the condition
    #             variable = ""
    #             ## The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition.
    #             pattern = ""
    #             ## Perform a case in-sensitive comparison. Defaults to false
    #             ignore_case = false
    #             ## Negate the result of the condition evaluation. Defaults to false
    #             negate = false

    #         }]
    #     }, {
    #         name = "name2"
    #         rule_sequence = 2
    #         request_header_configuration = null
    #         condition = null
    #         response_header_configuration = [{
    #             header_name = "Commonheader"
    #             header_value = "server"
    #         }]
    #     }]
    # }

##  ssl_certificate (optional) if not required either remove or put block as null
    ssl_certificate = null # [
    #     {
    #         name = "certname"
    #         data = "foo"
    #         password = ""
    #     }
    # ]

##  url_path_map (optional) if not required either remove or put block as null
    url_path_map = null # [
    #     {
    #         name = "urlpath"
    #         ## The Name of the Default Backend Address Pool which should be used for this URL Path Map. 
    #         ## Cannot be set if default_redirect_configuration_name is set. set as null if not required.
    #         default_backend_address_pool_name  = ""
    #         ## The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. 
    #         ## Cannot be set if default_redirect_configuration_name is set. set as null if not required.
    #         default_backend_http_settings_name = ""
    #         ## The Name of the Default Redirect Configuration which should be used for this URL Path Map. 
    #         ## Cannot be set if either default_backend_address_pool_name or default_backend_http_settings_name is set. set as null if not required.
    #         default_redirect_configuration_name = null
    #         ## The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs. set as null if not required.
    #         default_rewrite_rule_set_name = null

    #         ## path_rule required if url_path_map is used
    #         path_rule = [
    #             {
    #                 name                          = "urlpathmap"
    #                 ## A list of Paths used in this Path Rule
    #                 paths                         = [""]
    #                 ## The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
    #                 backend_address_pool_name     = ""
    #                 ## The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
    #                 backend_http_settings_name    = ""
    #                 ## The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if backend_address_pool_name or backend_http_settings_name is set.
    #                 redirect_configuration_name   = ""
    #                 ## The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
    #                 rewrite_rule_set_name         = ""
    #             }
    #         ]
    #     }
    # ]

## used to create diagnostic setting resource
    diag_object = {
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
        log = [["AllLogs", true, true, 80],]
        metric = [["AllMetrics", true, true, 80], ]
    }
}

output "web_app_firewall" {
  description = "List of waf"
  value = module.waf.azurerm_application_gateway
}

output "diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.waf.diagnostic_log
}