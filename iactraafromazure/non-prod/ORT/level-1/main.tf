terraform {
  backend "azurerm" {
    key                  = "level1/terraform.tfstate"
    resource_group_name  = "rg_ort_storageaccount_terraformstate"
    storage_account_name = "stmockortdzna0001"
    container_name       = "blob-mock-ortdzna-0001"
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

