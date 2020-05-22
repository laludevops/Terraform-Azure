locals {
# For naming convention purpose
  dev_internet_waf_naming_convention_info = {
    name          = var.dev_internet_waf_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.internet_zone_name
    tier          = var.cache_tier_name
  }
   dev_internet_apim_naming_convention_info = {
    name          = var.dev_internet_apim_name
    agency_code   = var.agency_code
    project_code  = var.project_code
    env           = var.env
    zone          = var.internet_zone_name
    tier          = var.cache_tier_name
  }
}

module "dev_internet_waf" {
    source = "../modules/az-terraform-web-app-firewall"

    resource_group_name = var.dev_internet_waf_resource_group_name
    location            = var.dev_internet_waf_location
    zone                = null
    enable_http2        = false

    naming_convention_info = local.dev_internet_waf_naming_convention_info

    tags = var.dev_internet_waf_tags

    gateway_ip_configuration = var.dev_internet_waf_gateway_ip_configuration
    

    sku_name        = var.dev_internet_waf_sku_name
    sku_tier        = var.dev_internet_waf_sku_tier
    sku_capacity    = var.dev_internet_waf_sku_capacity

    waf_enabled                     = var.dev_internet_waf_waf_enabled
    waf_firewall_mode               = var.dev_internet_waf_waf_firewall_mode
    waf_rule_set_type               = var.dev_internet_waf_waf_rule_set_type
    waf_rule_set_version            = var.dev_internet_waf_waf_rule_set_version
    waf_file_upload_limit_mb        = var.dev_internet_waf_waf_file_upload_limit_mb
    waf_request_body_check          = var.dev_internet_waf_waf_request_body_check
    waf_max_request_body_size_kb    = var.dev_internet_waf_waf_max_request_body_size_kb

    disabled_rule_group = var.dev_internet_waf_disabled_rule_group

    exclusion = var.dev_internet_waf_exclusion
    frontend_port = var.dev_internet_waf_frontend_port
    frontend_ip_configuration = var.dev_internet_waf_frontend_ip_configuration
    backend_address_pool = var.dev_internet_waf_backend_address_pool

    backend_http_settings = var.dev_internet_waf_backend_http_settings

    http_listener = var.dev_internet_waf_http_listener

    request_routing_rule = var.dev_internet_waf_request_routing_rule

    identity = var.dev_internet_waf_identity
    authentication_certificate = var.dev_internet_waf_authentication_certificate
    autoscale_capacity = var.dev_internet_waf_autoscale_capacity
    trusted_root_certificate = var.dev_internet_waf_trusted_root_certificate
    ssl_policy = var.dev_internet_waf_ssl_policy
    redirect_configuration = var.dev_internet_waf_redirect_configuration
    probe = var.dev_internet_waf_probe
    rewrite_rule_set = var.dev_internet_waf_rewrite_rule_set
    ssl_certificate = var.dev_internet_waf_ssl_certificate
    url_path_map = var.dev_internet_waf_url_path_map
    diag_object = var.dev_internet_waf_diag_object
}
module "dev_internet_apim" {
    source = "../modules/az-terraform-api-management"
  
    naming_convention_info = local.dev_internet_apim_naming_convention_info
    tags = var.dev_internet_apim_tags

    resource_group_name = var.dev_internet_apim_resource_group_name
    location            = var.dev_internet_apim_location
    publisher_name      = var.dev_internet_apim_publisher_name
    publisher_email     = var.dev_internet_apim_publisher_email
    sku_name            = var.dev_internet_apim_sku_name

    certificate = var.dev_internet_apim_certificate

    additional_location = var.dev_internet_apim_additional_location

    policy = var.dev_internet_apim_policy
    diag_object = var.dev_internet_apim_diag_object
}