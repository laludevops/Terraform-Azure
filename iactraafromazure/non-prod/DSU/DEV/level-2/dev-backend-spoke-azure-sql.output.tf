output "dev_backend_azsql_sqldb_output" {
  value = module.dev_backend_azsql_sql.sqldb_output
}

output "dev_backend_azsql_fully_qualified_domain_name" {
  value = module.dev_backend_azsql_sql.fully_qualified_domain_name
}

output "dev_backend_azsql_administrator_login" {
  value = module.dev_backend_azsql_sql.administrator_login
}

output "dev_backend_azsql_azurerm_sql_database_names" {
  value = module.dev_backend_azsql_sql.azurerm_sql_database_names
}

output "dev_backend_azsql_administrator_login_password" {
  value = module.dev_backend_azsql_sql.administrator_login_password
}

