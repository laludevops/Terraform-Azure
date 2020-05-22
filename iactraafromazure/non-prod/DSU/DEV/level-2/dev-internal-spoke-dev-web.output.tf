output "dev_intranet_web_app_firewall" {
  description = "List of waf"
  value = module.dev_intranet_waf.azurerm_application_gateway
}

output "dev_intranet_diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.dev_intranet_waf.diagnostic_log
}