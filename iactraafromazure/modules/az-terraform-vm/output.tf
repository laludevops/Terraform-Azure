output "vm_output" {
  description = "The virtual machine output."
  value       = azurerm_virtual_machine.vm_obj
}

output "vm_nic_output" {
  description = "The virtual machine network interface card output."
  value       = module.nic_obj.nic_output
}

output "ssh_private_key_pem" {
    depends_on = [azurerm_virtual_machine.vm]
    # sensitive = true
    value = base64encode(tls_private_key.ssh.private_key_pem)
}