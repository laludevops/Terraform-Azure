# vnet-irin-ortezna-0001
# 172.24.115.0/24

internet_ingress_egress_spoke_vnet_name                 = "cmt-21090011-Internet"
internet_ingress_egress_spoke_vnet_resource_group_name  = "cmt-21090011"
internet_ingress_egress_route_table_resource_group_name = "cmt-21090011"

internet_ingress_egress_nsg_resource_group_name = "rg_cmt-21090011_nsgasg"


internet_ingress_egress_tmt_0002_tier_cidr               = "172.24.115.0/26"
internet_ingress_egress_tmt_0002_tier_nsg_inbound_rules  = []
internet_ingress_egress_tmt_0002_tier_nsg_outbound_rules = []

internet_ingress_egress_tmt_0003_tier_cidr               = "172.24.115.64/26"
internet_ingress_egress_tmt_0003_tier_nsg_inbound_rules  = []
internet_ingress_egress_tmt_0003_tier_nsg_outbound_rules = []


internet_ingress_egress_gut_0001_tier_cidr               = "172.24.115.128/27"
internet_ingress_egress_gut_0001_tier_nsg_inbound_rules  = []
internet_ingress_egress_gut_0001_tier_nsg_outbound_rules = []


internet_ingress_egress_ingress_0001_tier_cidr               = "172.24.115.160/27"
internet_ingress_egress_ingress_0001_tier_nsg_inbound_rules  = []
internet_ingress_egress_ingress_0001_tier_nsg_outbound_rules = []


internet_ingress_egress_egress_0001_tier_cidr               = "172.24.115.192/27"
internet_ingress_egress_egress_0001_tier_nsg_inbound_rules  = []
internet_ingress_egress_egress_0001_tier_nsg_outbound_rules = []


internet_ingress_egress_tmt_0001_tier_cidr               = "172.24.115.224/27"
internet_ingress_egress_tmt_0001_tier_nsg_inbound_rules  = []
internet_ingress_egress_tmt_0001_tier_nsg_outbound_rules = []
