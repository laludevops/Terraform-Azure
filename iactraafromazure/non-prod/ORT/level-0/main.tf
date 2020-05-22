terraform {
  required_version = ">= 0.12.6"
}
provider "azurerm" {
  version             = "<2.0.0"
  storage_use_azuread = true
}

