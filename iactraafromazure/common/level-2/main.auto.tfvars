############################################################################################################
# level 1 settings
level1_stg_name            = "sstirasr2cmndznatfstate"
level1_container_name      = "sstcnt-iras-r2-cmn-dz-na-level1"
level1_key                 = "level1/terraform.tfstate"
level1_stg_access_key      = "6OSX3BwbMaQ7Btv2x9/UPuQ7qHfHOPqiU7nbIGjRsC0r6q/wRCKL63tsMeRNvbuj2AQjvZIIFCFqdNpsfvPC9Q=="
level1_resource_group_name = "rg-lz-iac"

# resource_group_name  = "terraform-test-resource-group"
# location             = "southeastasia"
# storage_account_name = "sstirasr2cmndznatfstate"
# container_name       = "sstcnt-iras-r2-cmn-dz-na-level1"
############################################################################################################


############################################################################################################
# cross zone settings
naming_convention_info = {
  "agency_code"  = "iras"
  "project_code" = "irasgcc"
  "env"          = "dev"
}

vm_disk_encryption_info = {
  encrypt_operation          = "EnableEncryption"
  vault_url                  = "https://sc-test-kv.vault.azure.net/"
  vault_resource_id          = "/subscriptions/9c773ff4-da83-41c8-9a85-83abcce71ac3/resourceGroups/terraform-test-resource-group/providers/Microsoft.KeyVault/vaults/sc-test-kv"
  vault_encryption_algorithm = "RSA-OAEP"
  vault_volume_type          = "All"
}

tags                 = {}
############################################################################################################