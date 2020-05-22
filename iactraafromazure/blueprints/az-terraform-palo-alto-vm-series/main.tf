# Configure the Microsoft Azure Provider
provider "azurerm" {
  version = "<2.0.0"

  # NOTE: Environment Variables can also be used for Service Principal authentication
  # Terraform also supports authenticating via the Azure CLI too.
  # see here for more info: http://terraform.io/docs/providers/azurerm/index.html

  # subscription_id = "954c5e98-51c5-4327-869c-863c1561a795"
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}

# Retrieve existing resource group
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Creating random string for use in Storage Account
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.resource_group_name
  }
  byte_length = 4
}