

output "public_portal_forward_proxy_asg_info" {
  value = module.public_portal_forward_proxy_asg.asg_output
}

output "public_portal_forward_proxy_with_lb_info" {
  value = module.public_portal_forward_proxy_with_lb.vm_with_load_balancer_output
}

