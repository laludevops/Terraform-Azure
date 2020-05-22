locals {
  enable_disk_encryption = var.enable_disk_encryption && var.disk_encryption_info != null && var.disk_encryption_info != {}
}

resource "azurerm_key_vault_key" "generated" {
  count        = local.enable_disk_encryption ? var.instance_count : 0
  name         = element(module.vm_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
  key_vault_id = var.disk_encryption_info.vault_resource_id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_virtual_machine_extension" "vmextension" {
  count                      = local.enable_disk_encryption ? var.instance_count : 0
  name                       = element(module.vm_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
  virtual_machine_id         = azurerm_virtual_machine.vm_obj[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = lower(var.os_type) == "linux" ? "AzureDiskEncryptionForLinux" : "AzureDiskEncryption"
  type_handler_version       = lower(var.os_type) == "linux" ? "1.1" : "2.2"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine.vm_obj, azurerm_key_vault_key.generated]

  settings = <<SETTINGS
    {
        "EncryptionOperation"   : "${var.disk_encryption_info.encrypt_operation}",
        "KeyVaultURL"           : "${var.disk_encryption_info.vault_url}",
        "KeyVaultResourceId"    : "${var.disk_encryption_info.vault_resource_id}",					
        "KeyEncryptionKeyURL"   : "${length(azurerm_key_vault_key.generated) > 0 ? azurerm_key_vault_key.generated[count.index].id : ""}",		
        "KekVaultResourceId"    : "${var.disk_encryption_info.vault_resource_id}",	
        "KeyEncryptionAlgorithm": "${var.disk_encryption_info.vault_encryption_algorithm}",
        "VolumeType"            : "${var.disk_encryption_info.vault_volume_type}"
    }

SETTINGS
  tags     = module.vm_name.naming_convention_output[var.naming_convention_info.name].tags.0
}
