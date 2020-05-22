terraform {
  backend "azurerm" {
    key = "level2/terraform.tfstate"
    # use_msi            = true
    resource_group_name  = "rg_common_storageaccount_terraformstate"
    storage_account_name = "stirincmndzna0001"
    container_name       = "blob-irin-cmndzna-0002"
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


# data "terraform_remote_state" "common_level_1" {
#   backend = "azurerm"
#   config = {
#     storage_account_name =  var.common_level_1_stg_name
#     container_name       =  var.common_level_1_container_name
#     key                  =  var.common_level_1_key
#     # access_key           =  var.common_level_1_stg_access_key
#     resource_group_name   = var.common_level_1_resource_group_name
#   }
# }



data "terraform_remote_state" "common_level_1" {
  backend = "azurerm"
  config = {
    key                  = "level1/terraform.tfstate"
    resource_group_name  = "rg_common_storageaccount_terraformstate"
    storage_account_name = "stirincmndzna0001"
    container_name       = "blob-irin-cmndzna-0001"
  }
}