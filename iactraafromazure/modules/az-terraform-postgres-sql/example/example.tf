# For naming convention purpose
locals {
  naming_convention_info = {
    name          = "postgresql"
    agency_code   = "iras"
    project_code  = "irasgcc" 
    env           = "dev" 
    zone          = "z1"
    tier          = "web"
  }

  resource_group_name = "rg-alex-iac"
  location            = "southeastasia"
}

data "azurerm_subnet" "subnet_sample1" {
  name                 = "Alex_subnet"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

data "azurerm_subnet" "subnet_sample2" {
  name                 = "postgres_subnet"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name 
}

module "postgresql" {
  source = "../"

## The naming convention used for postgres
  naming_convention_info = local.naming_convention_info

## firewall and vnet name that will be used by naming convertion to create a name
  firewall_name = "postgresql_firewall"
  vnet_name     = "postgresqlvnet"

## id of subnet (optional) if not required either remove for put as {}
  vnet_rules = {}
  # {
  #   subnet1 = {
  #     subnet_id = data.azurerm_subnet.subnet_sample1.id
  #   }
  #   subnet2 = {
  #     subnet_id = data.azurerm_subnet.subnet_sample2.id
  #   }
  # }
  

## resource group/location to be used in azure 
  resource_group_name = local.resource_group_name
  location            = local.location

## admin username and password of postgres server add if needed specific name and password
  # administrator_login     = null
  # administrator_password  = null

## tags to be used with naming convention, anything added here will be added to postgres sql tag
  tags = {
    "custom_tag" = "Custom tag as needed"
  }

  sku_name     = "GP_Gen5_2"
## sku property has been deprecated in favour of "sku_name" and will be removed in version 2.0 of the provider
  # sku_capacity = 2
  # sku_tier     = "GeneralPurpose"
  # sku_family   = "Gen5"

## storage profiles block
  storage_mb            = 5120
  backup_retention_days = 7
  geo_redundant_backup  = "Disabled"

## database version
  server_version  = "9.5"
## specify if SSL should be enforced on connections, possible values "Enabled", "Disabled"
  ssl_enforcement = "Enabled"

## List of database to be created in postgres server, no minimum requirement
  database = {
    db_1= {
      db_names     = "database_1"
      db_charset   = "UTF8"
      db_collation = "English_United States.1252"
    }
    db_2= {
      db_names     = "database_2"
      db_charset   = "UTF8"
      db_collation = "English_United States.1252"
    }
  }

## List of database configuration to be created in postgres server, no minimum requirement
  postgresql_configurations = {
    config_1= {
      config_name     = "backslash_quote"
      config_value    = "on"
    }
#    config_2= {
#      config_name     = "second config"
#      config_value    = "value"
#    }
  }

## Start and ip address range required by firewall (optional) if not required either remove for put as {}
  firewall_rules = {}
  # {
  #   firewall1 = {
  #     start_ip_address    = "1.0.0.0"
  #     end_ip_address      = "1.1.0.0"
  #   }
  #   firewall2 = {
  #     start_ip_address    = "2.0.0.0"
  #     end_ip_address      = "2.2.0.0"
  #   }
  # }

## log and metrics that is required by diagnostic log 
  diag_object = {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
    log = [["AllLogs", true, true, 80], ]
    metric = [["AllMetrics", true, true, 80], ]
  }
}


output "postgres" {
  description = "postgres"
  value = module.postgresql.azurerm_postgresql_server
}

output "postgresql_database" {
  description = "postgresql_database"
  value = module.postgresql.postgresql_database
}

output "firewall_rule" {
  description = "firewall_rule"
  value = module.postgresql.firewall_rule
}

output "vnet_rule" {
  description = "vnet_rule"
  value = module.postgresql.vnet_rule
}

output "diagnostic_log" {
  description = "diagnostic_log"
  value = module.postgresql.diagnostic_log
}