
# Create Interfaces for VM-Series
resource "azurerm_network_interface" "FW1-VNIC0" {
  name                = "INT-${var.fwName}-Mgmt"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig0"
    subnet_id                     = data.azurerm_subnet.mgmt.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = ""
  }

}
# untrust - ingress
# trust - egress

resource "azurerm_network_interface" "FW1-VNIC1" {
  name                 = "INT-${var.fwName}-Untrust"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = "true"
  enable_accelerated_networking = var.accelerated_networking == "yes" ? true : false

  ip_configuration {
    name                          = "ipconfig0"
    subnet_id                     = data.azurerm_subnet.untrust.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = ""
  }

}

resource "azurerm_network_interface" "FW1-VNIC2" {
  name                 = "INT-${var.fwName}-Trust"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = "true"
  enable_accelerated_networking = var.accelerated_networking == "yes" ? true : false

  ip_configuration {
    name                          = "ipconfig0"
    subnet_id                     = data.azurerm_subnet.trust.id
    private_ip_address_allocation = "dynamic"
  }
}


# Creating Storage Account for Boot Diagnostics for Serial Console access to VM-Series
resource "azurerm_storage_account" "diag-storage-account" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = var.resource_group_name
  location                 = data.azurerm_resource_group.main.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  depends_on = [random_id.randomId]
}


# Create VM-Series
resource "azurerm_virtual_machine" "FW1" {
  name                = var.fwName
  location            = data.azurerm_resource_group.main.location
  resource_group_name = var.resource_group_name
  vm_size             = var.vmSize
  zones               = var.zones

  delete_os_disk_on_termination = true

  plan {
    name      = var.imageSku
    publisher = "paloaltonetworks"
    product   = "vmseries1"
  }

  storage_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries1"
    sku       = var.imageSku
    version   = var.imageVersion
  }

  storage_os_disk {
    name              = "${var.fwName}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.fwName
    admin_username = var.adminUsername
    admin_password = var.adminPassword
    custom_data    = var.bootstrap == "yes" ? var.customdata : ""
  }

  primary_network_interface_id = azurerm_network_interface.FW1-VNIC0.id

  network_interface_ids = [
    azurerm_network_interface.FW1-VNIC0.id,
    azurerm_network_interface.FW1-VNIC1.id,
    azurerm_network_interface.FW1-VNIC2.id,
  ]

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }

  depends_on = [
    azurerm_network_interface.FW1-VNIC0,
    azurerm_network_interface.FW1-VNIC1,
    azurerm_network_interface.FW1-VNIC2,
    azurerm_storage_account.diag-storage-account,
  ]
}
