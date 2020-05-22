module "private_dns_a_record" {
  source      = "../az-terraform-naming-convention"
  name_format = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    for key, value in var.a_records :
    "${key}" => {
      name_info = merge(var.naming_convention_info, { name = coalesce(value.a_record_name, key) })
      tags      = var.tags
    }
  }
  resource_type = "a"
}
