# Vnet/Zone <Developer> variables
locals {
  developer_naming_convention_info = {
    project_code = var.project_code
    agency_code  = var.agency_code
    env          = var.env
    zone         = var.management_zone_name
    tier         = var.na_tier_name
  }

  developer_tags = merge(local.landing_zone_tags, {})

}

module "developer_spoke_route_table" {
  source              = "../../modules/az-terraform-route-table-routes"
  resource_group_name = var.developer_spoke_route_table_resource_group_name
  location            = var.location
  routes              = null
  naming_convention_info = merge(local.developer_naming_convention_info, {
    name = "0002"
  })
  tags = local.developer_tags
}

#region developer dev tier
module "developer_dev_tier" {
  source                  = "../../modules/az-terraform-network-subnet"
  resource_group_name     = var.developer_spoke_vnet_resource_group_name
  nsg_resource_group_name = module.level_1_resource_groups.rg_output.developer_spoke_nsg.name
  virtual_network_name    = var.developer_spoke_vnet_name
  location                = var.location
  naming_convention_info  = merge(local.developer_naming_convention_info, {})
  tags                    = merge(local.developer_tags, {})
  subnets = {
    "0003" = {
      cidr              = var.developer_dev_tier_cidr
      route_table_id    = module.developer_spoke_route_table.rt_output.id
      create_nsg        = true
      service_endpoints = var.developer_dev_tier_service_endpoints
      nsg_inbound       = var.developer_dev_tier_nsg_inbound_rules
      nsg_outbound      = var.developer_dev_tier_nsg_outbound_rules
      delegation        = var.developer_dev_tier_delegation
    }
  }
  diag_object  = local.common_subnet_diag_object
  netwatcher   = local.networkwatcher_object
  dependencies = [module.storage_account_network_watcher_logs, module.developer_spoke_route_table]
}
#end-region developer dev tier
module "developer_dev_tier_nsg_rule_deny_all" {
  source              = "../../modules/az-terraform-network-nsg-rules"
  resource_group_name = module.level_1_resource_groups.rg_output.developer_spoke_nsg.name
  nsg_name            = lookup(lookup(lookup(module.developer_dev_tier.snet_nsg_output, "0003", {}), "nsg_info", {}), "name", "")
  inbound_rules       = var.common_nsg_inbound_rule_deny_all
  outbound_rules      = var.common_nsg_outbound_rule_deny_all
}

