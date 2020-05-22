# vnet-irin-ortizna-0001

transit_hub_spoke_vnet_name                 = "cmt-21090007-Intranet"
transit_hub_spoke_vnet_resource_group_name  = "cmt-21090007"
transit_hub_route_table_resource_group_name = "cmt-21090007"

transit_hub_nsg_resource_group_name = "rg_cmt-21090007_nsgasg"


transit_hub_app_0001_tier_cidr               = "10.192.118.0/26"
transit_hub_app_0001_tier_nsg_inbound_rules  = []
transit_hub_app_0001_tier_nsg_outbound_rules = []


transit_hub_tmt_0001_tier_cidr               = "10.192.118.64/27"
transit_hub_tmt_0001_tier_nsg_inbound_rules  = []
transit_hub_tmt_0001_tier_nsg_outbound_rules = []


transit_hub_app_0002_tier_cidr               = "10.192.118.96/27"
transit_hub_app_0002_tier_nsg_inbound_rules  = []
transit_hub_app_0002_tier_nsg_outbound_rules = []


transit_hub_tmt_0002_tier_cidr               = "10.192.118.128/27"
transit_hub_tmt_0002_tier_nsg_inbound_rules  = []
transit_hub_tmt_0002_tier_nsg_outbound_rules = []


transit_hub_tmt_0003_tier_cidr               = "10.192.118.160/27"
transit_hub_tmt_0003_tier_nsg_inbound_rules  = []
transit_hub_tmt_0003_tier_nsg_outbound_rules = []


transit_hub_ingress_0001_tier_cidr               = "10.192.118.192/27"
transit_hub_ingress_0001_tier_nsg_inbound_rules  = []
transit_hub_ingress_0001_tier_nsg_outbound_rules = []


transit_hub_egress_0001_tier_cidr               = "10.192.118.224/27"
transit_hub_egress_0001_tier_nsg_inbound_rules  = []
transit_hub_egress_0001_tier_nsg_outbound_rules = []
