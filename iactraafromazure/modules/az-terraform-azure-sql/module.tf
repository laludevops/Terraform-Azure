
resource "random_string" "administrator_login" {
  length = 12
}

resource "random_password" "administrator_login_password" {
  length  = 32
  special = true
}

resource "random_integer" "random" {
  min = 100
  max = 999
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = module.sqlserver_name.naming_convention_output["${var.naming_convention_info.name}"].names.0
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = coalesce(var.adminuser, random_string.administrator_login.result)
  administrator_login_password = coalesce(var.adminpassword, random_password.administrator_login_password.result)

  dynamic "identity" {
    for_each = var.enable_managed_identity ? [1] : [0]

    content {
      type = "SystemAssigned"
    }
  }
  tags                         = module.sqlserver_name.naming_convention_output[var.naming_convention_info.name].tags.0
}

resource "azurerm_sql_database" "sql_database" {
  for_each                         = var.databases
  name                             = each.value.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  server_name                      = azurerm_sql_server.sqlserver.name
  collation                        = each.value.collation
  edition                          = each.value.edition
  requested_service_objective_name = each.value.requested_service_objective_name
  max_size_bytes                   = each.value.max_size_bytes
  tags                = module.sqldb_name.naming_convention_output[each.key].tags.0
}


# Allow access from Azure services 
resource "azurerm_sql_firewall_rule" "rule" {
  for_each            = var.firewall_rules
  name                = module.firewall_resource_name.naming_convention_output[each.key].names.0
  resource_group_name = azurerm_sql_server.sqlserver.resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = each.value.start_ipaddress
  end_ip_address      = each.value.end_ipaddress
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  for_each            = var.vnet_rules
  name                = module.vnet_resource_name.naming_convention_output[each.key].names.0
  resource_group_name = azurerm_sql_server.sqlserver.resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  subnet_id           = each.value.subnet_id
}
