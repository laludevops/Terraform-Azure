
# resource "azurerm_key_vault_key" "generated" {
#   count        = var.instance_count
#   name         = element(module.disk_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
#   key_vault_id = var.keyvault_id
#   key_type     = "RSA"
#   key_size     = 4096

#   key_opts = [
#     "decrypt",
#     "encrypt",
#     "sign",
#     "unwrapKey",
#     "verify",
#     "wrapKey",
#   ]
# }

# resource "azurerm_key_vault_secret" "aks_secret_obj" {
#   count        = var.instance_count
#   name         = element(module.disk_name.naming_convention_output[var.naming_convention_info.name].names, count.index)#"v2-test-kv"#[count.index].name
#   value        = "v2-testing"
#   key_vault_id = var.keyvault_id

#   #tags = module.akv_secret_name.naming_convention_output.akv_secret.tags.0
# }


resource "azurerm_managed_disk" "disk_obj" {
  count                = var.instance_count
  name                 = element(module.disk_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_iops_read_write = var.disk_iops_read_write
  disk_mbps_read_write = var.disk_mbps_read_write
  disk_size_gb         = var.disk_size_gb
  zones                = [(count.index % 3) + 1] #var.zone
  # dns_servers          = var.dns_servers
  #depends_on = [azurerm_key_vault_secret.aks_secret_obj,azurerm_key_vault_key.generated]
  tags       = element(module.disk_name.naming_convention_output[var.naming_convention_info.name].tags, count.index)

  # encryption_settings {
  #   enabled = var.enable_disk_encryption
  #   disk_encryption_key {
  #     secret_url      = azurerm_key_vault_secret.aks_secret_obj[count.index].id
  #     source_vault_id = var.keyvault_id
  #   }
  #   key_encryption_key {
  #     key_url         = azurerm_key_vault_key.generated[count.index].id
  #     source_vault_id = var.keyvault_id
  #   }
  # }
}
