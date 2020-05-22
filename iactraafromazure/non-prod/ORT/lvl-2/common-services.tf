
#Landing zone variables
locals {
  landing_zone_tags = {
    Landing-Zone = "level2"
    Location     = var.location
  }

  landing_zone_naming_convention = {
    project_code = var.project_code
    agency_code  = var.agency_code
    env          = var.env
  }
  # loga_id                           = module.common_log_analytics_workspace.loga_output.id
  # loga_workspace_id                 = module.common_log_analytics_workspace.loga_output.workspace_id
  loga_id = data.azurerm_log_analytics_workspace.loga_obj.id
}

data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = var.loga_workspace_name
  resource_group_name = var.loga_resource_group_name
}



module "internet_palo_alto_egress_tier_asg" {
  source              = "../../../modules/az-terraform-network-asg"
  location            = var.location
  resource_group_name = var.internet_ingress_egress_asg_resource_group_name
  naming_convention_info = merge(local.internet_ingress_egress_naming_convention_info, {
    name = var.internet_ig_eg_palo_alto_nic_trust_name
  })
  tags = local.internet_ingress_egress_tags
}

# # nic-asg association 
resource "azurerm_network_interface_application_security_group_association" "internet_palo_alto_egress_tier_asg_nic_association" {
  count                         = length(module.internet_ig_eg_palo_alto_nic_trust.nic_output)
  network_interface_id          = module.internet_ig_eg_palo_alto_nic_trust.nic_output[count.index].id
  application_security_group_id = module.internet_palo_alto_egress_tier_asg.asg_output.id
  ip_configuration_name         = module.internet_ig_eg_palo_alto_nic_trust.nic_output[count.index].ip_configuration[0].name
  depends_on                    = [module.internet_ig_eg_palo_alto_nic_trust, module.internet_palo_alto_egress_tier_asg]
}