module "insight_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  resource_type = "is"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
       name_info =  var.naming_convention_info
    
       tags = var.tags
    }
  }
}

module "read_telemetry_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "is"
  naming_convention_info = {
    for key, value in var.api_permissions :
      "${key}" => {
        name_info =  merge(var.naming_convention_info, { name = key})
        tags = var.tags
      }
  }
}