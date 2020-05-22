
//the following code is mock the vnet creation // This is for testing puposes only

terraform {
  required_version = ">= 0.12.6"
}

provider "azurerm" {
  version             = "<2.0.0"
  storage_use_azuread = true
  # use_msi            = true
}

locals {
  vnets = {
    "cmt-21090008-Intranet" = {
      rg            = "cmt-21090008"
      address_space = ["10.192.119.0/24"]
    }
    //devops
     "cmt-21090016-Intranet" = {
      rg            = "cmt-21090016"
      address_space = ["10.192.144.0/21"]
    } 
    //managmenent
    "cmt-21090012-Intranet" = {
      rg            = "cmt-21090012"
      address_space = ["10.192.160.0/23"]
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
