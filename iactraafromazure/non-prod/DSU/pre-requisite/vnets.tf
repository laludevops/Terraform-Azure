
//the following code is mock the vnet creation // This is for testing puposes only
locals {
  vnets = {
    "cmt-21090021-Intranet" = {
      rg            = "cmt-21090021"
      address_space = ["10.192.136.0/21"]
    }
    //devops
     "cmt-21090022-Intranet" = {
      rg            = "cmt-21090022"
      address_space = ["10.192.152.0/21"]
    } 
    //managmenent
    "cmt-21090020-Intranet" = {
      rg            = "cmt-21090020"
      address_space = ["10.192.128.0/21"]
    }
  }

  rgs = { for k, v in local.vnets : "${v.rg}" => {
    name     = v.rg
    location = "southeastasia"
    tags     = {}
    }
  }
}

module "common_resource_groups" {
  source          = "../../../modules/az-terraform-resource-group"
  resource_groups = local.rgs
}


resource "azurerm_virtual_network" "example" {
  for_each            = local.vnets
  name                = each.key
  location            = "southeastasia"
  resource_group_name = each.value.rg
  address_space       = each.value.address_space
  depends_on = [module.common_resource_groups]

}
