
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
  tags     = merge(module.rg_name.naming_convention_output[each.key].tags.0, { Name = each.value.name })
}
