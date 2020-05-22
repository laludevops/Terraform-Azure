# #generate name based on the convention
# locals {
#     naming_convention_info = {
#       for key, value in var.naming_convention_info : "${key}" => {
#         name_info = merge(value.name_info, { 
#           "res_type" = var.resource_type 
#         }) 
#         tags = lookup(value, local.metadata_tag_name, {})             
#       }
#     }
    
#     # tuple<name,instance_count,key,tags>
#     tuple_name_count_key = [for key, value in local.naming_convention_info : {
#       name = join(var.delimeter, compact([for v in local.order : lookup(value.name_info, v, "")]))
#       "${local.metadata_parent_key}" = key
#       "instance_index" =  lookup(value.name_info, local.metadata_instance_index, 1)
#       local_tag_values = [ for ktag, vtag in local.tag_info : lookup(value.name_info, vtag.nameinfo_key, vtag.default)]
#       tags = value.tags
      
#     }]

#    # Outputs a map  -> { subnet_1 = { name: [], tags = {} }, subnet_2 = { name: [], tags : {} } } 
#    # key array and tuple_naming_convention_info are zip mapped 
#     tuple_naming_convention_info = [ for key, value in local.tuple_name_count_key : {
#       names = [format("%s%s%03d", value.name, var.delimeter, value.instance_index)]
#       tags =  merge(value.tags, zipmap(keys(local.tag_info), value.local_tag_values))
#     }]

#     keys = [ for key, value in var.naming_convention_info : key ]

#     name_info_op = zipmap(local.keys, local.tuple_naming_convention_info)
# }
