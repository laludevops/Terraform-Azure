module "cosmosdb_resource_name" {
  source = "../az-terraform-naming-convention"
  name_format   = "res_type|-|project_code|-|env|-|zone|-|tier|-|name"
  resource_type = "cosdb"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
       name_info =  var.naming_convention_info
    
       tags = var.tags
    }
  }
}
