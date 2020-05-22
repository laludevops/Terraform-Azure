module "apim_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|-|project_code|-|env|zone|tier|-|name"
  resource_type = "apim"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
       name_info =  var.naming_convention_info
    
       tags = var.tags
    }
  }
}

# module "firewall_resource_name" {
#   source = "../az-terraform-naming-convention"
#   delimeter     = "_"
#   resource_type = "fw"
#   naming_convention_info = {
#     "${var.firewall_name}" = {
#        name_info =  merge(var.naming_convention_info, { name = var.firewall_name})
    
#        tags = var.tags
#     }
#   }
# }