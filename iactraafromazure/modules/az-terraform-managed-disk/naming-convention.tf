module "disk_name" {
  source      = "../az-terraform-naming-convention"
  name_format = "res_type|env|zone|tier|name|instance"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
      name_info = merge(var.naming_convention_info, { instance_count = var.instance_count })
      tags      = var.tags
    }
  }
  resource_type = "datasst"
}

