output "dev_internet_apim_apim" {
  description = "List of apim"
  value = module.dev_internet_apim.apim_list
}

output "dev_internet_apim_diagnostic_log" {
  description = "List of diagnostic_log"
  value = module.dev_internet_apim.diagnostic_log
}