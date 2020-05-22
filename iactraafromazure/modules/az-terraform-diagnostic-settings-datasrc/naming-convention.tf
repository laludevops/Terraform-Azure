module "diagnostic_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = { 
    for key, value in var.diag_object : "${key}" => {
      name_info = merge(var.naming_convention_info, 
      { 
        name = key
        instance_count = length(value.resource_id) 
      })
      tags      = var.tags
    }
  }
  resource_type = var.resource_type 
}
