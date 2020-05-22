module "postgresql_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format = "res_type|azpgsql|project_code|env|name"
  resource_type = "postgresql"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
       name_info =  var.naming_convention_info
       tags = var.tags
    }
  }
}

module "vnet_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format = "res_type|azpgsql|project_code|env|name"
  resource_type = "vnet"
  naming_convention_info = {
     for key, value in var.vnet_rules : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}

module "firewall_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format = "res_type|azpgsql|project_code|env|name"
  resource_type = "fw"
  naming_convention_info = {
     for key, value in var.firewall_rules : "${key}" => {
         name_info = merge(var.naming_convention_info, { name = key })
         tags = var.tags
      }
  }
}