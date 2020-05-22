output "aks_output" {
  value = azurerm_kubernetes_cluster.aks_obj
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_obj.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks_obj.kube_config_raw
  sensitive   = true
}

output "ssh_key" {
  value = tls_private_key.key
  sensitive   = true
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_obj.name
}