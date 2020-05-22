# module "nsg_rule" {
#     source = ""
#     resource_group_name = var.resource_group_name
#     location = var.location
#     nsg_name = "nsg-irasgcc-dev-nsg2"

# }


# module "nsg_rules_example" {
#     source = "../"
#     resource_group_name = local.resource_group_name
#     location = local.location
#         nsg_name = "nsg-irasgcc-dev-nsg2"
#         inbound_rules = [
#           ["LDAP-t", "100", "Inbound", "Allow", "tcp", "3389", "389", "*", "*",  [], []]
#         ]
#         outbound_rules = [
#           ["LDAP-t", "100", "Outbound", "Allow", "tcp", "3389", "389", "*", "*",  [], []]

#         ]
#     diag_object = { 
#       log_analytics_workspace_id = local.loga_id
#       log  = [
#                 # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
#                 ["AllLogs", true, true, 80],
#       ]
#       metric = [
#       ]
#     }
# }
