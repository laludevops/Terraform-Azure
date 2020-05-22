terraform {
  backend "azurerm" {
    key                  = "level1/terraform.tfstate"
    resource_group_name  = "rg_dsu_storageaccount_terraformstate"
    storage_account_name = "stirindsudzna0001"
    container_name       = "blob-irin-dsudzna-dsu-0001"
  }
}

terraform {
  required_version = ">= 0.12.6"
}

provider "azurerm" {
  version             = "<2.0.0"
  storage_use_azuread = true
  # user_msi            = true
}

