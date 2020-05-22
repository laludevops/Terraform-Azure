output "api_key" {
  description = "List of api key value"
  value = azurerm_application_insights_api_key.api_keys
}

output "azure_insight" {
  value = azurerm_application_insights.insight
}
