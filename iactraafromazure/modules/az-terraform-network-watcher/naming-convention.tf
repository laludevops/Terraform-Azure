#NSG name
module "nw_name" {
  source = "../az-terraform-naming-convention"
  delimeter     = "-"
  naming_convention_info = {
    nw = {
      name_info =  var.naming_convention_info
      tags = var.tags
    }
  }
  resource_type = "nw" 
}

