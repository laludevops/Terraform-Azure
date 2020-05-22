dev_intranet_waf_name                = "waf"
dev_intranet_waf_resource_group_name = "rg-alex-iac"
dev_intranet_waf_location            = "southeastasia"
dev_intranet_waf_zone                = null
dev_intranet_waf_enable_http2        = false
dev_intranet_waf_tags = {
    custom_tag = "Custom tag as needed"
}
dev_intranet_waf_gateway_ip_configuration = {
    gateway = {
        subnet_id       = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-alex-iac/providers/Microsoft.Network/virtualNetworks/Alex_vnet/subnets/frontend"
    }
}
dev_intranet_waf_sku_name        = "WAF_v2" 
dev_intranet_waf_sku_tier        = "WAF_v2"
dev_intranet_waf_sku_capacity    = 1
dev_intranet_waf_waf_enabled                     = true
dev_intranet_waf_waf_firewall_mode               = "Detection"
dev_intranet_waf_waf_rule_set_type               = "OWASP"
dev_intranet_waf_waf_rule_set_version            = "3.0"
dev_intranet_waf_waf_file_upload_limit_mb        = "100"
dev_intranet_waf_waf_request_body_check          = true
dev_intranet_waf_waf_max_request_body_size_kb    = "128"
dev_intranet_waf_disabled_rule_group = null
dev_intranet_waf_exclusion = null
dev_intranet_waf_frontend_port = {
    fep = {
        portno = 80
    }
}
dev_intranet_waf_frontend_ip_configuration = {
    fic = {
        public_ip_address_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-alex-iac/providers/Microsoft.Network/publicIPAddresses/alex-ip"
        subnet_id = null
        private_ip_address = null
        private_ip_address_allocation = null
    }
}
dev_intranet_waf_backend_address_pool = {
    bapn = {
        fqdns       = null
        ipaddresses = null
    }
}
dev_intranet_waf_backend_http_settings = {
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
        authentication_certificate = null
        be_trusted_root_certificate_name = null
        connection_draining = {
            enabled = true
            drain_timeout_sec = 3600
        }
    }
}
dev_intranet_waf_http_listener = {
    httpl = {
        frontend_ip_configuration_name = "fic"
        frontend_port_name = "fep"
        protocol = "Http"
        host_name = "http_host_name"
        require_sni = false
        ssl_certificate_name = null 
        http_custom_error_configuration = null
    }
}
dev_intranet_waf_request_routing_rule = {
    rrr = {
        http_listener_name = "httpl"
        backend_address_pool_name = "bapn"
        backend_http_settings_name = "settings1"
        rule_type = "basic"
        rewrite_rule_set_name = null
        url_path_map_name = null
    }
}
dev_intranet_waf_identity = null
dev_intranet_waf_authentication_certificate = null
dev_intranet_waf_autoscale_capacity = null
dev_intranet_waf_trusted_root_certificate = null
dev_intranet_waf_ssl_policy = null
dev_intranet_waf_redirect_configuration = null
dev_intranet_waf_probe = [
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
dev_intranet_waf_rewrite_rule_set = null
dev_intranet_waf_ssl_certificate = null
dev_intranet_waf_url_path_map = null 
dev_intranet_waf_diag_object = {
    log_analytics_workspace_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-alex-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-alex-001"
    log = [["AllLogs", true, true, 80],]
    metric = [["AllMetrics", true, true, 80], ]
}

