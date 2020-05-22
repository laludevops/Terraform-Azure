
# #metadata keys 
# locals {
#     metadata_parent_key     = "parent_key"
#     metadata_delimeter      = "delimeter"
#     metadata_instance_count = "instance_count"
#     delimeter               = ""
# }

# #convention enforced in the module
# locals {
#   order      = ["res_type", "project_code", "env", "zone", "tier", "name"]
#   local_tags = {
#     inherited   = "local"
#     abc       = "234"

#   }
# }

# #generate name based on the convention
# locals {
#     tmp_name_info = [for key, value in var.naming_convention_info : {
        
#             name = join(var.delimeter, compact([for v in local.order : lookup(value.name_info, v, "")]))

#             "${local.metadata_instance_count}" = lookup(value.name_info, local.metadata_instance_count, 1) <= 0 ? 1 : lookup(value.name_info, local.metadata_instance_count, 1) 

#             "${local.metadata_parent_key}" = key

#             tags = merge(local.local_tags, lookup(value, "tags"))
#     }]

#   # outputs a list(map) -> [{ subnet_1 = { name = [], tags = {} } }, { subnet_1 = { name = [], tags = {} } }]
#     name_info_output_1 = [for key, value in local.tmp_name_info : {
#             lookup(value, local.metadata_parent_key) =  {
#                     name = [ for cntr in range(lookup(value, local.metadata_instance_count, 1)) : format("%s%s%03d", value.name, var.delimeter, cntr+1)]

#                     tags = lookup(value, "tags")
#               }
#     }]

#    # Optimum sol. Outputs a map  -> { subnet_1 = { name: [], tags = {} }, subnet_2 = { name: [], tags : {} } } 
#    # key array and tmp_name_info_2 are zip mapped 
#     tmp_name_info_2 = [for key, value in local.tmp_name_info : {
#                     name = [ for cntr in range(lookup(value, local.metadata_instance_count, 1)) : format("%s%s%03d", value.name, var.delimeter, cntr+1)]

#                     tags = lookup(value, "tags")
#     }]

#     keys = [for key, value in var.naming_convention_info : key ]

#     name_info_output2 = zipmap(local.keys, local.tmp_name_info_2)
#  }

# #output the list(map) 
# output "name_info_output_1" {
#   description = "Outputs the list(map)"
#   value = local.name_info_output_1
# }

# # output the map
# # preferred output 
# output "naming_convention_output" {
#   description = "Output the map. Use this output instead of /'name_info_output_1'"
#   value = local.name_info_output2
# }
