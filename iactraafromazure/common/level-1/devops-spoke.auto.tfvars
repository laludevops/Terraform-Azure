devops_spoke_vnet_name                       = "cmt-21090016-Intranet"
devops_spoke_vnet_resource_group_name        = "cmt-21090016"
devops_spoke_route_table_resource_group_name = "cmt-21090016"

devops_spoke_nsg_resource_group_name         = "rg_cmt-21090016_nsgasg"

devops_aks_tier_cidr               = "10.192.144.0/22"
devops_aks_tier_nsg_inbound_rules  = []
devops_aks_tier_nsg_outbound_rules = []
devops_aks_tier_service_endpoints  = ["Microsoft.Sql", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.KeyVault"]

devops_tmt_0001_tier_cidr               = "10.192.148.0/24"
devops_tmt_0001_tier_nsg_inbound_rules  = []
devops_tmt_0001_tier_nsg_outbound_rules = []

devops_tmt_0002_tier_cidr               = "10.192.149.0/24"
devops_tmt_0002_tier_nsg_inbound_rules  = []
devops_tmt_0002_tier_nsg_outbound_rules = []

devops_app_tier_cidr               = "10.192.150.0/24"
devops_app_tier_nsg_inbound_rules  = []
devops_app_tier_nsg_outbound_rules = []
devops_app_tier_service_endpoints  = ["Microsoft.Sql", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.KeyVault"]

devops_db_tier_cidr               = "10.192.151.0/24"
devops_db_tier_nsg_inbound_rules  = []
devops_db_tier_nsg_outbound_rules = []
devops_db_tier_service_endpoints  = []
