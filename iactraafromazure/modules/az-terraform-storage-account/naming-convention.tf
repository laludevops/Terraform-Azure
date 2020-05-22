#storage account name
module "sst_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|project_code|env|zone|tier|name"
  naming_convention_info = {
    "${var.naming_convention_info.name}" =  {
        name_info = var.naming_convention_info
        tags      = var.tags 
      }
  }
  resource_type = "st" 
}

#storage account container name
module "sst_cnt_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    for key, value in var.containers : 
      "${key}" => {
        name_info = merge(var.naming_convention_info, { name = key })
        tags      = var.tags 
      }
  }
  resource_type = "blob" 
}

