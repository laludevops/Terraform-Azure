resource "azurerm_application_gateway" "waf" {
  name                = module.waf_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
  tags                = module.waf_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zone != [""] && var.zone != null ? var.zone : null
  enable_http2        = var.enable_http2 != null ? var.enable_http2 : false

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool != null ? var.backend_address_pool : {}

    content {
      name = module.backend_address_pool_name.naming_convention_output[backend_address_pool.key].names.0
      fqdns = backend_address_pool.value.fqdns != "" ? backend_address_pool.value.fqdns : null
      ip_addresses = backend_address_pool.value.ipaddresses == "" ? null : backend_address_pool.value.ipaddresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings != null ? var.backend_http_settings : {}

    content{
      name                  = module.http_setting_name.naming_convention_output[backend_http_settings.key].names.0
      affinity_cookie_name  = backend_http_settings.value.be_affinity_cookie_name
      cookie_based_affinity = backend_http_settings.value.be_http_cookie_based_affinity
      path                  = backend_http_settings.value.be_http_path
      port                  = backend_http_settings.value.be_http_port
      protocol              = backend_http_settings.value.be_http_protocol
      request_timeout       = backend_http_settings.value.be_http_request_timeout
      probe_name            = backend_http_settings.value.be_probe_name
      host_name             = backend_http_settings.value.be_hostname == "" ? null : backend_http_settings.value.be_hostname
      #this part should be refactored to be made dynamic backed settings for different app
      pick_host_name_from_backend_address  = backend_http_settings.value.be_pick_host_name_from_backend_http_settings

      trusted_root_certificate_names = backend_http_settings.value.be_trusted_root_certificate_name != null && backend_http_settings.value.be_trusted_root_certificate_name != [] ? backend_http_settings.value.be_trusted_root_certificate_name : null
      
      dynamic "authentication_certificate" {
        for_each = backend_http_settings.value.authentication_certificate != null  ? backend_http_settings.value.authentication_certificate : []

        content {
          name = authentication_certificate.value.name
        }
      }
      
      dynamic "connection_draining" {
        for_each = backend_http_settings.value.connection_draining != null  ? [1] : []

        content {
          enabled = backend_http_settings.value.connection_draining.enabled
          drain_timeout_sec = backend_http_settings.value.connection_draining.drain_timeout_sec
        }
      }
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration != null ? var.frontend_ip_configuration : {}

    content {
      name                 = module.frontend_ip_configuration_name.naming_convention_output[frontend_ip_configuration.key].names.0
      subnet_id            = frontend_ip_configuration.value.subnet_id
      private_ip_address   = frontend_ip_configuration.value.private_ip_address
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
      #create a public ip with static for WAF_V2
      public_ip_address_id = frontend_ip_configuration.value.public_ip_address_id
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port != null ? var.frontend_port : {}

    content{
      name = module.frontend_port_name.naming_convention_output[frontend_port.key].names.0
      port = frontend_port.value.portno
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configuration != null ? var.gateway_ip_configuration : {}

    content {
      name      = module.gateway_ip_name.naming_convention_output[gateway_ip_configuration.key].names.0
      subnet_id =  gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listener != null ? var.http_listener : {}

    content{
      name                           = module.listener_name.naming_convention_output[http_listener.key].names.0
      frontend_ip_configuration_name = module.frontend_ip_configuration_name.naming_convention_output[http_listener.value.frontend_ip_configuration_name].names.0
      frontend_port_name             = module.frontend_port_name.naming_convention_output[http_listener.value.frontend_port_name].names.0
      protocol                       = http_listener.value.protocol
      host_name                      = http_listener.value.host_name
      require_sni                    = http_listener.value.require_sni
      ssl_certificate_name           = http_listener.value.ssl_certificate_name

      dynamic "custom_error_configuration" {
        for_each = http_listener.value.http_custom_error_configuration != null ? http_listener.value.http_custom_error_configuration : []
        content{
          status_code = custom_error_configuration.value.status_code
          custom_error_page_url = custom_error_configuration.value.custom_error_page_url
        }
      }
    }
  }

  dynamic "identity"  {
    for_each = var.identity != null  ? [1] : []
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule != null ? var.request_routing_rule : {}
    
    content {
      name                       = module.request_routing_rule_name.naming_convention_output[request_routing_rule.key].names.0
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = module.listener_name.naming_convention_output[request_routing_rule.value.http_listener_name].names.0
      backend_address_pool_name  = module.backend_address_pool_name.naming_convention_output[request_routing_rule.value.backend_address_pool_name].names.0
      backend_http_settings_name = module.http_setting_name.naming_convention_output[request_routing_rule.value.backend_http_settings_name].names.0
      rewrite_rule_set_name      = request_routing_rule.value.rewrite_rule_set_name
      url_path_map_name          = request_routing_rule.value.url_path_map_name
    }
  }

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  dynamic "authentication_certificate" {
    for_each = var.authentication_certificate != null  ? [1] : []

    content {
      name = var.authentication_certificate.name
      data = var.authentication_certificate.data
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificate != null  ? [1] : []

    content {
      name = var.trusted_root_certificate.name
      data = var.trusted_root_certificate.data
    }
  }

  dynamic "ssl_policy" {
    for_each = var.ssl_policy != null ? [1] : []

    content{
      disabled_protocols    = var.ssl_policy.disabled_protocols
      policy_type           = var.ssl_policy.policy_type
      policy_name           = var.ssl_policy.policy_name
      cipher_suites         = var.ssl_policy.cipher_suites
      min_protocol_version  = var.ssl_policy.min_protocol_version
    }
  }

  waf_configuration {
    enabled = var.waf_enabled
    firewall_mode  = var.waf_firewall_mode
    rule_set_type = var.waf_rule_set_type
    rule_set_version = var.waf_rule_set_version
    file_upload_limit_mb = var.waf_file_upload_limit_mb
    request_body_check = var.waf_request_body_check
    max_request_body_size_kb = var.waf_max_request_body_size_kb

    dynamic "disabled_rule_group" {
      for_each = var.disabled_rule_group != null ? var.disabled_rule_group : []

      content {
        rule_group_name = disabled_rule_group.value.rule_group_name
        rules = disabled_rule_group.value.rules
      }
    }

    dynamic "exclusion" {
      for_each = var.exclusion != null ? var.exclusion : []

      content {
        match_variable = exclusion.value.match_variable
        selector_match_operator = exclusion.value.selector_match_operator
        selector = exclusion.value.selector
      }
    }
     
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_capacity != null ? [1] : []

    content {
      min_capacity = var.autoscale_capacity.autoscale_min_capacity
      max_capacity = var.autoscale_capacity.autoscale_max_capacity
    }
  }

  dynamic "custom_error_configuration" {
    for_each = var.custom_error_configuration != null ? [1] : []

    content {
      status_code = var.custom_error_configuration.status_code
      custom_error_page_url = var.custom_error_configuration.custom_error_page_url
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.redirect_configuration != null ? [1] : []

    content {
      name                  = var.redirect_configuration.name
      redirect_type         = var.redirect_configuration.redirect_type
      target_listener_name  = var.redirect_configuration.target_listener_name
      target_url            = var.redirect_configuration.target_url
      include_path          = var.redirect_configuration.include_path
      include_query_string  = var.redirect_configuration.include_query_string
    }
  }

  dynamic "probe" {
    for_each = var.probe != null ? var.probe : []
    
    content {
      name     = probe.value.name
      interval = probe.value.interval
      protocol = probe.value.protocol
      path = probe.value.path
      timeout = probe.value.timeout
      unhealthy_threshold = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      host = probe.value.host
      minimum_servers = probe.value.minimum_servers

      dynamic "match" {
        for_each = probe.value.match != null ? [1] : []

        content {
          body = probe.value.match.body
          status_code = probe.value.match.status_code
        }
      }
    }

  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_set != null ? [1] : []

    content{
      name = var.rewrite_rule_set.name
      dynamic "rewrite_rule" {
        for_each = var.rewrite_rule_set.rewrite_rule != null ? var.rewrite_rule_set.rewrite_rule : []

        content{
          name = rewrite_rule.value.name
          rule_sequence = rewrite_rule.value.rule_sequence
          dynamic "response_header_configuration" {
            for_each = rewrite_rule.value.response_header_configuration != null ? rewrite_rule.value.response_header_configuration : []

            content{
              header_name = response_header_configuration.value.header_name
              header_value = response_header_configuration.value.header_value
            }
          }

          dynamic "request_header_configuration" {
            for_each = rewrite_rule.value.request_header_configuration != null ? rewrite_rule.value.request_header_configuration : []

            content{
              header_name = request_header_configuration.value.header_name
              header_value = request_header_configuration.value.header_value
            }
          }

          dynamic "condition" {
            for_each = rewrite_rule.value.condition != null ? rewrite_rule.value.condition : []

            content{
              variable = condition.value.variable
              pattern = condition.value.pattern
              ignore_case = condition.value.ignore_case
              negate = condition.value.negate
            }
          }

        }
      }

    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificate != null ? var.ssl_certificate : []

    content{
      name = ssl_certificate.value.name
      data = ssl_certificate.value.data
      password = ssl_certificate.value.password
    }
  }

}
