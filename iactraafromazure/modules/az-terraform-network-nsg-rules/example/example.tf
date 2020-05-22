module "nsg_rules_example" {
  source              = "../"
  resource_group_name = "rg-lz-iac"
  nsg_name            = "nsg-irin-cmndztmt-0001"
  inbound_rules = [
    {
      priority                                   = "100"
      access                                     = "Deny"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      source_application_security_group_ids      = null
      destination_application_security_group_ids = null
    }
  ]
  outbound_rules = [
    {
      priority                                   = "100"
      access                                     = "Deny"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "Internet"
      source_application_security_group_ids      = null
      destination_application_security_group_ids = null
    }
  ]
}
