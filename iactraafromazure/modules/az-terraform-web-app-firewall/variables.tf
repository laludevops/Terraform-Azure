variable "resource_group_name" { 
     type = string
}

variable "location" {
     type = string
     default = "southeastasia"
}

variable "sku_name" { 
     type = string
}

variable "sku_tier" { 
     type = string
}

variable "sku_capacity" { 
     type = string
}

variable "waf_enabled" { 
     type = bool
}

variable "waf_firewall_mode" { 
     type = string
     
}

variable "waf_rule_set_type" { 
     type = string
}

variable "waf_rule_set_version" { 
     type = string
} 

variable "waf_file_upload_limit_mb" { 
     type = string
     default = 100
}

variable "waf_request_body_check" { 
     type = bool
     default = true
}

variable "waf_max_request_body_size_kb" { 
     type = string
     default = "128"
}


variable "disabled_rule_group" { 
     type = list(object({
          rule_group_name = string
          rules = list(string)
     }))
} 

variable "exclusion" { 
     type = list(object({
          match_variable = string
          selector_match_operator = string
          selector = string
     }))
} 

variable "frontend_ip_configuration" {
     type = map(object({
          public_ip_address_id = string
          subnet_id = string
          private_ip_address = string
          private_ip_address_allocation = string
     }))
}

variable "frontend_port" {
     type = map(object({
          portno = number 
     }))
}

variable "backend_address_pool" {
     type = map(object({
          fqdns = list(string)
          ipaddresses = list(string)
     }))
}

variable "gateway_ip_configuration" {
     type = map(object({
          subnet_id = string
     }))
}


variable "backend_http_settings" {
     type = map(object({
          # be_http_setting_name                         = string
          be_affinity_cookie_name                      = string
          be_http_cookie_based_affinity                = string
          be_http_path                                 = string
          be_http_port                                 = string
          be_http_protocol                             = string
          be_http_request_timeout                      = string
          be_probe_name                                = string
          be_hostname                                  = string
          be_pick_host_name_from_backend_http_settings = bool
          be_trusted_root_certificate_name             = list(string)

          authentication_certificate = list(object({
                         name = string
                    }))

          connection_draining = object(
                    {
                         enabled = bool
                         drain_timeout_sec = number
                    }
               )
     }))
}

variable "http_listener" {
     type = map(object({
          frontend_ip_configuration_name = string
          frontend_port_name = string
          protocol = string
          host_name = string
          require_sni = string
          ssl_certificate_name = string

          http_custom_error_configuration = list(object({
               status_code = string
               custom_error_page_url = string
          }))
     }))
  
}

variable "request_routing_rule" {
     type = map(object({

          http_listener_name = string
          backend_address_pool_name = string
          backend_http_settings_name = string
          rule_type = string
          rewrite_rule_set_name = string
          url_path_map_name = string
     }))
}

 variable "probe" {
     type = list(object(
          {
               host = string
               name = string
               protocol = string
               path = string
               timeout = number
               interval = number
               unhealthy_threshold = number
               pick_host_name_from_backend_http_settings = bool
               minimum_servers = number
               match = object({
                    body = string
                    status_code = list(string)
               })
          }
     ))
     }

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
              agency_code   = string
              project_code  = string
              env           = string
              zone          = string 
              tier          = string
    })
}

variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    })
}

variable "tags" {
  description = "(optional) User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "zone" {
     type = list(string)
     default = null
}

variable "autoscale_capacity" {
     type = object(
          {
               autoscale_min_capacity = number
               autoscale_max_capacity = number
          }
     )
     default = null
}

 variable "authentication_certificate" {
     type = object(
          {
               name = string
               data = string
          }
     )
     default = null
 }

 variable "trusted_root_certificate" {
     type = object(
          {
               name = string
               data = string
          }
     )
     default = null
 }

 variable "ssl_policy" {
     type = object(
          {
               disabled_protocols   = list(string)
               policy_type          = string
               policy_name          = string
               cipher_suites        = list(string)
               min_protocol_version = string
          }
     )
     default = null
 }

 variable "enable_http2" {
      type = bool
      default = false
 }

 variable "identity" {
     type = object(
          {
               type           = string
               identity_ids   = list(string)
          }
     )
     default = null
 }

 variable "custom_error_configuration" {
     type = object(
          {
               status_code           = string
               custom_error_page_url   = list(string)
          }
     )
     default = null
 }

 variable "redirect_configuration" {
     type = object(
          {
               name                 = string
               redirect_type        = string
               target_listener_name = string
               target_url           = string
               include_path         = bool
               include_query_string = bool
          }
     )
     default = null
 }

 variable "ssl_certificate" {
     type = list(object(
          {
               name                 = string
               data                 = string
               password             = string
          }
     ))
     default = null
 }

 variable "url_path_map" {
     type = list(object(
          {
               name                                    = string
               default_backend_address_pool_name       = string
               default_backend_http_settings_name      = string
               default_redirect_configuration_name     = string     
               default_rewrite_rule_set_name           = string   

               path_rule = list(object({
                    name                          = string
                    paths                         = list(string)
                    backend_address_pool_name     = string
                    backend_http_settings_name    = string
                    redirect_configuration_name   = string
                    rewrite_rule_set_name         = string
               }))
          }
     ))
     default = null
 }

  variable "rewrite_rule_set" {
     type = object(
          {
               name           = string

               rewrite_rule   = list(object({
                    name     = string
                    rule_sequence  = number
                    condition = list(object({
                         variable    = string
                         pattern    = string
                         ignore_case = bool
                         negate      = bool
                    }))
                    request_header_configuration  = list(object({
                         header_name  = string
                         header_value = string
                    }))
                    response_header_configuration = list(object({
                         header_name  = string
                         header_value = string
                    }))
               }))
          }
     )
     default = null
 }