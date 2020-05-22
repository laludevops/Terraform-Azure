resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = module.la_workspace_name.naming_convention_output["${var.naming_convention_info.name}"].names.0
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.sku
  tags                = module.la_workspace_name.naming_convention_output["${var.naming_convention_info.name}"].tags.0
  depends_on          = [var.dependencies]
}

locals {
  solution_list = keys(var.solution_plan_map)
}

resource "azurerm_log_analytics_solution" "la_solution" {
  count                 = length(local.solution_list)
  solution_name         = element(local.solution_list, count.index)
  location              = var.location
  resource_group_name   = var.resource_group
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  workspace_name        = azurerm_log_analytics_workspace.log_analytics.name

  // tags = module.la_solution_name.naming_convention_output[element(local.solution_list, count.index)].tags
  // Tags not implemented in TF for azurerm_log_analytics_solution

  plan {
      product        = var.solution_plan_map[element(local.solution_list, count.index)].product
      publisher      = var.solution_plan_map[element(local.solution_list, count.index)].publisher
    }
  }