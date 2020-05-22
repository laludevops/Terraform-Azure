terraform {
  backend "azurerm" {
    key                  = "level2/terraform.tfstate"
    resource_group_name  = "rg_common_storageaccount_terraformstate"
    storage_account_name = "stmockcmndzna0001"
    container_name       = "blob-mock-cmndzna-0002"
  }
}


terraform {
  required_version = ">= 0.12.6"
}

provider "azurerm" {
  version             = "<2.0.0"
  storage_use_azuread = true
  # use_msi            = true
}

data "terraform_remote_state" "cmn_level_1" {
  backend = "azurerm"
  config = {
    key                  = "level1/terraform.tfstate"
    resource_group_name  = "rg_common_storageaccount_terraformstate"
    storage_account_name = "stmockcmndzna0001"
    container_name       = "blob-mock-cmndzna-0001"
  }
}