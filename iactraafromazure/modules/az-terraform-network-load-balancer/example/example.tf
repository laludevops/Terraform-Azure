

locals {
  # For naming convention purpose
  naming_convention_info = {
    name         = "tst"
    agency_code  = "iras"
    project_code = "irasgcc"
    env          = "dev"
    zone         = "z1"
    tier         = "web"
  }
  resource_group_name = "rg-alex-iac"
  tags                = {}
}

data "azurerm_log_analytics_workspace" "log_example" {
  name                = "loga-irasgcc-dev-z1-web-alex-001"
  resource_group_name = local.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = "cosmosdb_subnet"
  virtual_network_name = "Alex_vnet"
  resource_group_name  = local.resource_group_name
}

module "load_balancer" {
  source              = "../"
  location            = "southeastasia"
  resource_group_name = local.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id
  static_ip           = ""
  sku                 = "Standard"
  lb_rules = {
    rule_one = {
      probe_port              = "80"
      probe_protocol          = "Tcp"
      lb_port                 = "80"
      backend_port            = "80"
      load_distribution       = "Default"
      idle_timeout_in_minutes = 4
      request_path            = "/"
    }
  }
  diag_object = {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_example.id
    log = [
      ["LoadBalancerAlertEvent", true, true, 80],
      ["LoadBalancerProbeHealthStatus", true, true, 80],
    ]
    metric = [["AllMetrics", true, true, 80], ]
  }
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags

}
