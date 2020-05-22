#storage account container name
module "rg_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    for key, value in var.resource_groups : 
      "${key}" => {
        name_info = merge(value.naming_convention_info, { name = value.name })
        tags      = value.tags 
      }
  }
  resource_type = "rg" 
}
