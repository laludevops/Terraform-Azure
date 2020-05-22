output "network_load_balancer" {
    value = azurerm_lb.lb_obj
}

output "azurerm_lb_backend_address_pool_output" {
    value = azurerm_lb_backend_address_pool.lb_backend
}