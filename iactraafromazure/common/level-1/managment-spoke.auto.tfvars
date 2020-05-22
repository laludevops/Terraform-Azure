management_spoke_vnet_name                       = "cmt-21090012-Intranet"
management_spoke_vnet_resource_group_name        = "cmt-21090012"
management_spoke_route_table_resource_group_name = "cmt-21090012"

management_spoke_nsg_resource_group_name         = "rg_cmt-21090012_nsgasg"

management_tmt_0001_tier_cidr               = "10.192.160.0/25"
management_tmt_0001_tier_service_endpoints  = ["Microsoft.Sql", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.KeyVault"]
management_tmt_0001_tier_nsg_inbound_rules  = []
management_tmt_0001_tier_nsg_outbound_rules = []

management_db_tier_cidr               = "10.192.160.128/25"
management_db_tier_nsg_inbound_rules  = []
management_db_tier_nsg_outbound_rules = []
management_db_tier_service_endpoints  = []

management_tmt_0004_tier_cidr               = "10.192.161.0/26"
management_tmt_0004_tier_nsg_inbound_rules  = []
management_tmt_0004_tier_nsg_outbound_rules = []

management_tmt_0002_tier_cidr               = "10.192.161.64/27"
management_tmt_0002_tier_service_endpoints  = ["Microsoft.Sql", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.KeyVault"]
management_tmt_0002_tier_nsg_inbound_rules  = []
management_tmt_0002_tier_nsg_outbound_rules = []

management_tmt_0003_tier_cidr               = "10.192.161.96/27"
management_tmt_0003_tier_service_endpoints  = []
management_tmt_0003_tier_nsg_inbound_rules  = []
management_tmt_0003_tier_nsg_outbound_rules = []

management_tmt_0005_tier_cidr               = "10.192.161.128/27"
management_tmt_0005_tier_nsg_inbound_rules  = []
management_tmt_0005_tier_nsg_outbound_rules = []

management_tmt_0006_tier_cidr               = "10.192.161.160/27"
management_tmt_0006_tier_nsg_inbound_rules  = []
management_tmt_0006_tier_nsg_outbound_rules = []

management_hsm_tier_cidr               = "10.192.161.192/28"
management_hsm_tier_nsg_inbound_rules  = []
management_hsm_tier_nsg_outbound_rules = []
