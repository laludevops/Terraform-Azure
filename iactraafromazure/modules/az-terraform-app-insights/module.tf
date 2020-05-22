resource "azurerm_application_insights" "insight" {
  name                = module.insight_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  tags                = module.insight_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0
}


resource "azurerm_application_insights_api_key" "api_keys" {
  for_each                = var.api_permissions
  name                    = module.read_telemetry_name.naming_convention_output[each.key].names.0
  application_insights_id = azurerm_application_insights.insight.id
  read_permissions        = each.value.read_permissions
  write_permissions       = each.value.write_permissions
}