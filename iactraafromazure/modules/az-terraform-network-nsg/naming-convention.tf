#NSG name
module "nsg_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    for key, value in var.nsg_info : 
      "${key}" => {
        name_info = merge(var.naming_convention_info, { name = key })
        tags      = var.tags 
    }
  }
  resource_type = "nsg" 
}


