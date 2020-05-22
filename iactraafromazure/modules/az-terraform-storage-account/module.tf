locals {
  account_tier             = (var.kind == "FileStorage" ? "Premium" : split("_", var.sku)[0])
  account_replication_type = (local.account_tier == "Premium" ? "LRS" : split("_", var.sku)[1])
}

resource "azurerm_storage_account" "sst_obj" {
  name                      = module.sst_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  access_tier               = var.access_tier
  enable_blob_encryption    = true
  enable_file_encryption    = true
  enable_https_traffic_only = var.https_only
  tags                      = module.sst_name.naming_convention_output[var.naming_convention_info.name].tags.0

  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }
  depends_on          = [var.dependencies]
}


locals {
  name_keys = keys(module.sst_cnt_name.naming_convention_output)
}

resource "azurerm_storage_container" "ss_cnt_obj" {
  for_each              = var.containers
  name                  = coalesce(each.value.name, module.sst_cnt_name.naming_convention_output[each.key].names.0)
  storage_account_name  = azurerm_storage_account.sst_obj.name
  container_access_type = each.value.access_type
}

resource "azurerm_advanced_threat_protection" "threat_obj" {
  target_resource_id = azurerm_storage_account.sst_obj.id
  enabled            = true
  depends_on = [azurerm_storage_account.sst_obj]
  
}