module "asg_name" {
  source        = "../az-terraform-naming-convention"
  resource_type = "asg"
  name_format   = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
      name_info = var.naming_convention_info
      tags      = var.tags
    }
  }
}
