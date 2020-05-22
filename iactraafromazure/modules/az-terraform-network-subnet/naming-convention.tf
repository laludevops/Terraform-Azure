module "subnet_name" {
  source                  = "../az-terraform-naming-convention"
  resource_type           = "snet"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info  = {
    for key, value in var.subnets : 
      "${key}" => {
        name_info = merge(var.naming_convention_info, { name = key })
        tags      = var.tags 
    }
  }
}
