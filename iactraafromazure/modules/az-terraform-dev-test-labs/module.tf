module "caf_name_dtlab" {
  source  = "../az-terraform-caf-naming"
    
  name    = var.app_name
  type    = "dtlab"
  convention  = var.naming_convention
}


resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}

resource "azurerm_dev_test_lab" "dtlab" {
  name                = module.caf_name_dtlab.dtlab
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = var.tags
}



resource "azurerm_dev_test_virtual_network" "example" {
  name                = "example-network"
  lab_name            = "${azurerm_dev_test_lab.dtlab.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  subnet {
    use_public_ip_address           = "Allow"
    use_in_virtual_machine_creation = "Allow"
  }
}

resource "azurerm_dev_test_windows_virtual_machine" "example" {
  name                   = "example-vm03"
  lab_name               = "${azurerm_dev_test_lab.dtlab.name}"
  resource_group_name    = "${azurerm_resource_group.rg.name}"
  location               = "${azurerm_resource_group.rg.location}"
  size                   = "Standard_DS2"
  username               = "exampleuser99"
  password               = "Pa$$w0rd1234!"
  lab_virtual_network_id = "${azurerm_dev_test_virtual_network.example.id}"
  lab_subnet_name        = "${azurerm_dev_test_virtual_network.example.subnet.0.name}"
  storage_type           = "Premium"
  notes                  = "Some notes about this Virtual Machine."

  gallery_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}