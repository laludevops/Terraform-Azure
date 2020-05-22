# vnet-irin-ortezna-0002
//10.192.120.0/24
public_portal_spoke_vnet_name                 = "cmt-21090009-Intranet"
public_portal_spoke_vnet_resource_group_name  = "cmt-21090009"
public_portal_route_table_resource_group_name = "cmt-21090009"

public_portal_nsg_resource_group_name         = "rg_cmt-21090009_nsgasg"

public_portal_web_0001_tier_cidr               = "10.192.120.0/27"
public_portal_web_0001_tier_nsg_inbound_rules  = []
public_portal_web_0001_tier_nsg_outbound_rules = []

public_portal_app_0001_tier_cidr               = "10.192.120.64/27"
public_portal_app_0001_tier_nsg_inbound_rules  = []
public_portal_app_0001_tier_nsg_outbound_rules = []

public_portal_db_0001_tier_cidr               = "10.192.120.96/27"
public_portal_db_0001_tier_nsg_inbound_rules  = []
public_portal_db_0001_tier_nsg_outbound_rules = []
public_portal_db_0001_tier_service_endpoints  = []

public_portal_gut_0002_tier_cidr               = "10.192.120.128/27"
public_portal_gut_0002_tier_nsg_inbound_rules  = []
public_portal_gut_0002_tier_nsg_outbound_rules = []

public_portal_int_0001_tier_cidr               = "10.192.120.160/27"
public_portal_int_0001_tier_nsg_inbound_rules  = []
public_portal_int_0001_tier_nsg_outbound_rules = []

public_portal_app_0002_tier_cidr               = "10.192.120.192/27"
public_portal_app_0002_tier_nsg_inbound_rules  = []
public_portal_app_0002_tier_nsg_outbound_rules = []

public_portal_app_0003_tier_cidr               = "10.192.120.32/27"
public_portal_app_0003_tier_nsg_inbound_rules  = []
public_portal_app_0003_tier_nsg_outbound_rules = []

public_portal_db_0002_tier_cidr               = "10.192.120.224/27"
public_portal_db_0002_tier_nsg_inbound_rules  = []
public_portal_db_0002_tier_nsg_outbound_rules = []
