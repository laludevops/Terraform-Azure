output "dev_backend_aks_output" {
  value = module.dev_backend_aks_build.aks_output
}

output "dev_backend_aks_kube_config" {
  value = module.dev_backend_aks_build.kube_config
}

output "dev_backend_aks_kube_config_raw" {
  value = module.dev_backend_aks_build.kube_config_raw
}

output "dev_backend_aks_ssh_key" {
  value = module.dev_backend_aks_build.ssh_key
}

output "dev_backend_aks_kubernetes_cluster_name" {
  value = module.dev_backend_aks_build.kubernetes_cluster_name
}
