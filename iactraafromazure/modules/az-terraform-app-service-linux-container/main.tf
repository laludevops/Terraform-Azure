resource "azurerm_app_service" "app_service" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  app_settings        = var.app_settings

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|${var.container_name}"
    always_on        = "true"
  }

  # Configure STDOUT and STDERR log from container
  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 100
      }
    }
  }
  # identity {
  #   type = "SystemAssigned"
  # }

  tags = var.tags
}
