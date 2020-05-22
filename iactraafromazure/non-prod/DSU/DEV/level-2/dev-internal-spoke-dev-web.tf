locals {
# For naming convention purpose
  dev_intranet_waf_naming_convention_info = {
    name          = var.dev_intranet_waf_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.intranet_zone_name
    tier          = var.cache_tier_name
  }
}

module "dev_intranet_waf" {
    source = "../../../../modules/az-terraform-web-app-firewall"

    resource_group_name = var.dev_intranet_waf_resource_group_name
    location            = var.dev_intranet_waf_location
    zone                = null
    enable_http2        = false

    naming_convention_info = local.dev_intranet_waf_naming_convention_info

    tags = var.dev_intranet_waf_tags

    gateway_ip_configuration = var.dev_intranet_waf_gateway_ip_configuration
    

    sku_name        = var.dev_intranet_waf_sku_name
    sku_tier        = var.dev_intranet_waf_sku_tier
    sku_capacity    = var.dev_intranet_waf_sku_capacity

    waf_enabled                     = var.dev_intranet_waf_waf_enabled
    waf_firewall_mode               = var.dev_intranet_waf_waf_firewall_mode
    waf_rule_set_type               = var.dev_intranet_waf_waf_rule_set_type
    waf_rule_set_version            = var.dev_intranet_waf_waf_rule_set_version
    waf_file_upload_limit_mb        = var.dev_intranet_waf_waf_file_upload_limit_mb
    waf_request_body_check          = var.dev_intranet_waf_waf_request_body_check
    waf_max_request_body_size_kb    = var.dev_intranet_waf_waf_max_request_body_size_kb

    disabled_rule_group = var.dev_intranet_waf_disabled_rule_group

    exclusion = var.dev_intranet_waf_exclusion
    frontend_port = var.dev_intranet_waf_frontend_port
    frontend_ip_configuration = var.dev_intranet_waf_frontend_ip_configuration
    backend_address_pool = var.dev_intranet_waf_backend_address_pool

    backend_http_settings = var.dev_intranet_waf_backend_http_settings

    http_listener = var.dev_intranet_waf_http_listener

    request_routing_rule = var.dev_intranet_waf_request_routing_rule

    identity = var.dev_intranet_waf_identity
    authentication_certificate = var.dev_intranet_waf_authentication_certificate
    autoscale_capacity = var.dev_intranet_waf_autoscale_capacity
    trusted_root_certificate = var.dev_intranet_waf_trusted_root_certificate
    ssl_policy = var.dev_intranet_waf_ssl_policy
    redirect_configuration = var.dev_intranet_waf_redirect_configuration
    probe = var.dev_intranet_waf_probe
    rewrite_rule_set = var.dev_intranet_waf_rewrite_rule_set
    ssl_certificate = var.dev_intranet_waf_ssl_certificate
    url_path_map = var.dev_intranet_waf_url_path_map
    diag_object = var.dev_intranet_waf_diag_object
}