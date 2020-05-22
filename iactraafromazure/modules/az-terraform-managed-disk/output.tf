output "disk_output" {
    value = [ for k,v in azurerm_managed_disk.disk_obj : v ]
}
