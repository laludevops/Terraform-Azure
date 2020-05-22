
//the following code is mock the vnet creation // This is for testing puposes only
locals {
  vnets = {
    //transit_hub
    "cmt-21090007-Intranet" = {
      rg            = "cmt-21090007"
      address_space = ["10.192.118.0/24"]
    }
    //public
    "cmt-21090009-Intranet" = {
      rg            = "cmt-21090009"
      address_space = ["10.192.120.0/24"]
    }
    //iz_ingress_egress
    "cmt-21090010-Intranet" = {
      rg            = "cmt-21090010"
      address_space = ["10.192.121.0/24"]
    }
    //ez_ingress_egress
    "cmt-21090011-Internet" = {
      rg            = "cmt-21090011"
      address_space = ["172.24.115.0/24"]
    }
  }

  rgs = { for k, v in local.vnets : "${v.rg}" => {
    name     = v.rg
    location = "southeastasia"
    tags     = {}
    }
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = local.rgs
  name     = each.value.name
  location = each.value.location
  tags     = {}
}



resource "azurerm_virtual_network" "example" {
  for_each            = local.vnets
  name                = each.key
  location            = "southeastasia"
  resource_group_name = each.value.rg
  address_space       = each.value.address_space
  depends_on          = [azurerm_resource_group.rg]

}
