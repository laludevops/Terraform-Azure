
  dev_internet_app_asp_name                = "asp"
  dev_internet_app_asp_resource_group_name = "rg-alex-iac"
  dev_internet_app_asp_location            = "southeastasia"
  dev_internet_app_asp_max_worker_count    = 5
  dev_internet_app_asp_sku = {
    tier     = "Isolated"
    size     = "I1"
    capacity = 1
  }
  dev_internet_app_asp_tags                   = {
    custom_tag = "Custom tag as needed"
  }

  dev_internet_app_ase_name                = "ase2"
  dev_internet_app_ase_resource_group_name = "rg-alex-iac"
  dev_internet_app_ase_location            = "southeastasia"

  dev_internet_app_ase_kind                      = "ASEV2"
  dev_internet_app_ase_vnet_id                   = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-alex-iac/providers/Microsoft.Network/virtualNetworks/Alex_vnet/subnets/ase_subnet"
  dev_internet_app_ase_subnet_name               = "ase_subnet"
  dev_internet_app_ase_internalLoadBalancingMode = ""
  dev_internet_app_ase_tags                      = {
    custom_tag = "Custom tag as needed"
  }



