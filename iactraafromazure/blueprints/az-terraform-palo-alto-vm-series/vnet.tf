# Retrieve virtual network
data "azurerm_virtual_network" "fw-vnet" {
  name                = var.virtualNetworkName
  resource_group_name = var.resource_group_name
}

#Reference subnets
data "azurerm_subnet" "mgmt" {
  name                 = var.Mgmt-Subnet
  virtual_network_name = var.virtualNetworkName
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "untrust" {
  name                 = var.Untrust-Subnet
  virtual_network_name = var.virtualNetworkName
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "trust" {
  name                 = var.Trust-Subnet
  virtual_network_name = var.virtualNetworkName
  resource_group_name  = var.resource_group_name
}

