

module "waf_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "waf"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
       name_info =  var.naming_convention_info
    
       tags = var.tags
    }
  }


}

module "gateway_ip_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "gwip"
  naming_convention_info = {
     for key, value in var.gateway_ip_configuration : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "backend_address_pool_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "bapn"
  naming_convention_info = {
     for key, value in var.backend_address_pool : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "frontend_port_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "fpn"
  naming_convention_info = {
     for key, value in var.frontend_port : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "frontend_ip_configuration_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "ficn"
  naming_convention_info = {
     for key, value in var.frontend_ip_configuration : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "http_setting_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "hsn"
  naming_convention_info = {
     for key, value in var.backend_http_settings : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "listener_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "ln"
  naming_convention_info = {
     for key, value in var.http_listener : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "request_routing_rule_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "rrr"
  naming_convention_info = {
     for key, value in var.request_routing_rule : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}