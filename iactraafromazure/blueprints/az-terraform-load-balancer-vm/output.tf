output "vm_with_load_balancer_output" {
  value = {
    vm = module.virtual_machines.vm_output
    nic = module.virtual_machines.vm_nic_output
    #lb = module.virtual_machines.vm_output
  }
}