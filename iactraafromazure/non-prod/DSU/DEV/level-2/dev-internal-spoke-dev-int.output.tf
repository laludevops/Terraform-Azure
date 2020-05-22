output "dev_intranet_apim_apim" {
  description = "List of apim"
  value = module.dev_intranet_apim.apim_list
}

output "dev_intranet_apim_diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.dev_intranet_apim.diagnostic_log
}