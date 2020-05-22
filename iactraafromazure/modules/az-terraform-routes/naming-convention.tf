#storage account container name
locals {
  routes = var.routes == null ? {} : var.routes
}

module "rt_route_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|-|name"
  naming_convention_info = {
    for key, value in local.routes : 
      "${key}" => {
        name_info = merge(var.naming_convention_info, { name = key })
        tags      = var.tags 
      }
      if var.routes != null
  }
  resource_type = "rou" 
}
