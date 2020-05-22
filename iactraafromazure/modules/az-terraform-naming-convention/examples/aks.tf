module "aks_name" {
  source        = "../"
  resource_type = "aks"
  name_format   = "res_type|-|project_code|-|env|zone|tier|-|name|instance"
  naming_convention_info = {
    "aks_cluster_1" = {
      name_info = {
        start_index    = 2
        "project_code" = "irasgcc"
        "env"          = "dev"
        "zone"         = "z1"
        "tier"         = "web"
        "name"         = "aks1"
        instance_index = 2
      }
      tags = {
        "custom_tag" = "passed_as_argument"
      }
    }
    "aks_cluster_2" = {
      name_info = {
        start_index    = 3
        "project_code" = "isds"
        "env"          = "dev"
        "zone"         = "z1"
        "tier"         = "web"
        "name"         = "aks2"
        instance_count = 2
      }
      tags = {
        "resourcetype" = "aks"
      }
    }
  }

}

output "aks_name_op_map" {
  description = "Output the map."
  value       = module.aks_name.naming_convention_output
}
# output "aks_name_op_map_name" {
#   description = "Output the map."
#   value = module.aks_name.naming_convention_output.aks_cluster_1.names
# }
# output "aks_name_op_map_tags" {
#   description = "Output the map."
#   value = module.aks_name.naming_convention_output.aks_cluster_1.tags
# }


