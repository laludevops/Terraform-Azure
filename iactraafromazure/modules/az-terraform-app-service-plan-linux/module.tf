resource "azurerm_app_service_plan" "asp_linux_obj" {
  name                         = module.asp_name.naming_convention_output[var.naming_convention_info.name].names.0
  location                     = var.location
  resource_group_name          = var.resource_group_name
  maximum_elastic_worker_count = var.max_worker_count
  app_service_environment_id   = var.ase_id
  per_site_scaling             = var.enable_independent_app_scaling
  kind                         = "Linux"
  reserved                     = true
  tags                         = module.asp_name.naming_convention_output[var.naming_convention_info.name].tags.0
  sku {
    tier     = var.sku.tier
    size     = var.sku.size
    capacity = var.sku.capacity
  }
}
