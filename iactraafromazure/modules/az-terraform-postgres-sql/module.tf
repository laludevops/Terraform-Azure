## random string and random password resource for database admin username and password
resource "random_string" "administrator_login" {
  length  = 12
  special = false
  number  = false
  upper   = false
}

resource "random_password" "administrator_login_password" {
  length  = 32
  special = true
  override_special = "@!"
}

resource "azurerm_postgresql_server" "server" {
  name                = module.postgresql_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  storage_profile {
    storage_mb            = var.storage_mb
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup  = var.geo_redundant_backup
  }
  administrator_login          = coalesce(var.administrator_login , random_string.administrator_login.result)
  administrator_login_password = coalesce(var.administrator_password , random_password.administrator_login_password.result)
  version                      = var.server_version
  ssl_enforcement              = var.ssl_enforcement
  tags = module.postgresql_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0
}

resource "azurerm_postgresql_database" "dbs" {
  for_each = var.database

  name                = each.value.db_names
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  charset             = each.value.db_charset
  collation           = each.value.db_collation
}

resource "azurerm_postgresql_firewall_rule" "firewall_rules" {
  for_each = var.firewall_rules

  name                = module.firewall_resource_name.naming_convention_output[each.key].names.0
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules" {
  for_each = var.vnet_rules

  name                = module.vnet_resource_name.naming_convention_output[each.key].names.0
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  subnet_id           = each.value.subnet_id
}

resource "azurerm_postgresql_configuration" "db_configs" {
  for_each = var.postgresql_configurations

  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name

  name  = each.value.config_name
  value = each.value.config_value
}

