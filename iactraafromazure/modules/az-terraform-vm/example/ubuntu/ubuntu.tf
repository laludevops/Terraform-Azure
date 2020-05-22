locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "we"
}


locals {
  resource_group_name = "rg-sri-iac"
  vnet_name           = "vnet-sri"
  location            = "southeastasia"
  naming_convention_info = {
    "name"         = "sd"
    "agency_code"  = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags    = {}
  loga_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-lz-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-mad-001"
}


data "azurerm_subnet" "example" {
  name                 = "snet-irasgcc-devz1web-s1"
  virtual_network_name = "vnet-iac-sri"
  resource_group_name  = local.resource_group_name
}

module "virtual_machine" {
  source              = "../../"
  location            = local.location
  resource_group_name = local.resource_group_name
  os_type             = "linux"
  instance_count      = 1
  nic_info = {
    subnet_id = data.azurerm_subnet.example.id
    nsg_id    = null
    nics = {
      nic1 = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  image = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  vm_size                = "Standard_D4s_v3"
  admin_username         = "admin123"
  admin_password         = "adMin%6541"
  naming_convention_info = local.naming_convention_info
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log = [
    ]
    metric = [
      ["AllMetrics", true, true, 80],
      ["AllMetrics", true, true, 80],
    ]
  }
  tags = local.tags

  disk_encryption_info = {
    encrypt_operation          = "EnableEncryption"
    vault_url                  = "https://akvirasisdsdeveznavt.vault.azure.net/"
    vault_resource_id          = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourceGroups/rg-iaz-lz-dev/providers/Microsoft.KeyVault/vaults/akvirasisdsdeveznavt"
    vault_encryption_algorithm = "RSA-OAEP"
    vault_volume_type          = "All"
  }
}

output "vm_output_ssh_keys" {
  value = module.virtual_machine.ssh_private_key_pem
}

output "vm_nic_output" {
  description = "The virtual machine network interface card output."
  value       = module.virtual_machine.vm_nic_output
}
