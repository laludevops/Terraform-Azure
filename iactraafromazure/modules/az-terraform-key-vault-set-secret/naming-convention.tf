#akv name
module "akv_secret_name" {
  source = "../az-terraform-naming-convention"
  name_format             = "res_type|agency_code|project_code|env|zone|tier|name"
  naming_convention_info = {
    akv_secret =  {
        name_info = var.naming_convention_info
        tags      = var.tags 
      }
  }
  resource_type = "akvs" 
}