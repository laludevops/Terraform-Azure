#Route table name
module "rsv_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    "${var.naming_convention_info.name}" =  {
        name_info = var.naming_convention_info
        tags      = var.tags 
      }
  }
  resource_type = "rsv" 
}
