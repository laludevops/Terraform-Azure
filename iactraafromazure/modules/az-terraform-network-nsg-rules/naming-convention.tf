locals {

  inbounds = { for key, value in local.inbound_rules : "${key}" => {
    protocol = value.protocol == "*" ? "any" : value.protocol
    access   = value.access
    port     = value.source_port_range == "*" ? "any" : value.source_port_range
    }
  }
  outbounds = { for key, value in local.outbound_rules : "${key}" => {
    protocol = value.protocol == "*" ? "any" : value.protocol
    access   = value.access
    port     = value.source_port_range == "*" ? "any" : value.source_port_range
    }
  }

  inbound_names = {
    for k, value in local.inbounds :
    "${k}" => {
      name = "nsgr-${value.access}-${value.protocol}-${value.port}-in"
    }
  }

  outbound_names = {
    for k, value in local.outbounds :
    "${k}" => {
      name = "nsgr-${value.access}-${value.protocol}-${value.port}-in"
    }
  }

}


# module "nsg_inbound_rule_name" {
#   source = "../az-terraform-naming-convention"
#   name_format     = "access|-|protocol|-|port|-|rule_type"
#   naming_convention_info = {
#     for key, value in local.inbound_rules : 
#       "${key}" => {
#         name_info = {
#           access    = value.access
#           protocol  = value.protocol
#           port      = value.port
#           rule_type = "Inbound"
#         }
#         tags      = {}
#     }
#   }
#   resource_type = "nsgr" 
# }

# #NSG name
# module "nsg_outbound_rule_name" {
#   source = "../az-terraform-naming-convention"
#   name_format     = "access|-|protocol|-|port|-|rule_type"
#   naming_convention_info = {
#     for key, value in local.outbound_rules : 
#       "${key}" => {
#         name_info = {
#           access    = value.access
#           protocol  = value.protocol
#           port      = value.port
#           rule_type = "Outbound"
#         }
#         tags      = {}
#     }
#   }
#   resource_type = "nsgr" 
# }
