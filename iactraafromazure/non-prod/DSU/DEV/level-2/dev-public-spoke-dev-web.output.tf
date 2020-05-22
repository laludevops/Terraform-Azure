output "dev_internet_web_app_firewall" {
  description = "List of waf"
  value = module.dev_internet_waf.azurerm_application_gateway
}

output "dev_internet_diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.dev_internet_waf.diagnostic_log
}