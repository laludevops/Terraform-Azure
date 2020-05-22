# /*
# input - > naming_convention_info =  [
# {
#   name_info = {}
#   tags = {}
# }]

# output ->  [
#   {
#     names: []
#     tags: {}
#   },
#   {
#     names: []
#     tags: {}
#   }
# ]
# */

# #metadata keys 
# locals {
#     metadata_parent_key     = "parent_key"
#     metadata_delimeter      = "delimeter"
#     metadata_instance_count = "instance_count"
#     metadata_tag_name       = "tags"
# }


# #convention enforced in the module
# locals {
#   #TODO: Add convention for each element in order array as per IRAS Naming Convention
#   convention = {
#     type = "name"
#     max = 8
#     min = 8
#     trail = "0"
#     fmt = "%s" 
#   }
#   order      = ["res_type", "project_code", "env", "zone", "tier", "name"]
#   local_tags = {
#         "CreatedBy" = "Terraform"
#   }
# }

# #generate name based on the convention
# locals {
#     naming_convention_info = [ for naming_convention_info in var.naming_convention_info : {
#     name_info =  merge(naming_convention_info.name_info, { "res_type" = var.resource_type })
#     tags      = lookup(naming_convention_info, local.metadata_tag_name, {})
#     }]
    
#     # #tuple of<instance_count, name> -> eg <3, aks-xx-yy-zzz, tags> 
#     tuple_cntr_name_tags =  [for naming_convention_info in local.naming_convention_info : {
#      cnt  = lookup(naming_convention_info.name_info, local.metadata_instance_count, 1)
#      name = join(var.delimeter, compact([for v in local.order : lookup(naming_convention_info.name_info, v, "")]))
#      tags = naming_convention_info.tags
#     }]

   
#     name_info_op = [ for tuple in local.tuple_cntr_name_tags : {
#         names = [ for cntr in range(tuple.cnt) : format("%s%s%03d", tuple.name, var.delimeter, cntr+1) ]
#         tags = tuple.tags
#     }]
# }

# #output the list(map) 
# output "naming_convention_output" {
#   description = "Outputs the list(map)"
#   value = local.name_info_op
# }