terraform {
  backend "azurerm" {
    key = "level1/terraform.tfstate"
    # use_msi            = true
    resource_group_name  = "rg_common_storageaccount_terraformstate"
    storage_account_name = "stmockcmndzna0001"
    container_name       = "blob-mock-cmndzna-0001"
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
