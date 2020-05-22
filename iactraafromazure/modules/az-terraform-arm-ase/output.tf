output "id" {
  value = lookup(azurerm_template_deployment.ase.outputs, "id")
  description = "App Service Environment Resource Id"
}
