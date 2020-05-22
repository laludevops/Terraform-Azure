#ASG related ##################
variable "public_portal_asg_resource_group_name" {
  type        = string
}

#end region ASG related 

# Load Balancer Related ##################
variable "public_portal_forward_proxy_with_lb_public_ip_address_id" {
  description = "Public Ip Address for the load balancer"
  type        = string
}

variable "public_portal_forward_proxy_with_lb_static_ip" {
  description = "Static ip of the frontend config"
  type        = string
}


variable "public_portal_forward_proxy_with_lb_rules_probe_port" {
  type = string
}
variable "public_portal_forward_proxy_with_lb_rules_probe_protocol" {
  type = string
}
variable "public_portal_forward_proxy_with_lb_rules_lb_port" {
  type = string
}
variable "public_portal_forward_proxy_with_lb_rules_backend_port" {
  type = string
}
variable "public_portal_forward_proxy_with_lb_rules_load_distribution" {
  type = string
}
variable "public_portal_forward_proxy_with_lb_rules_idle_timeout_in_minutes" {
  type = string
}



variable "public_portal_forward_proxy_with_lb_sku" {
  description = "The SKU of Azure Load Balancer. Accepted values are only Standard"
  type        = string
}


#end region Load balancer

variable "public_portal_forward_proxy_name" {
  type = string
}

# Virtual Machine Related ##################
variable "public_portal_forward_proxy_vm_resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}


variable "public_portal_forward_proxy_vm_instance_count" {
  type        = number
  description = "(Optional) Specifies the number of the Virtual Machines. Minimum 2 for vm with load balancer."
}
variable "public_portal_forward_proxy_vm_admin_username" {
  type        = string
  description = "(Required) Specifies the user name of the Virtual Machine."
}
variable "public_portal_forward_proxy_vm_admin_password" {
  type        = string
  description = "(Required) Specifies the user password of the Virtual Machine."
}
variable "public_portal_forward_proxy_vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the Virtual Machine."
}

variable "public_portal_forward_proxy_vm_disable_password_authentication" {
  type        = bool
  description = "(Optional) Disable passwords authentication"
}

variable "public_portal_forward_proxy_vm_os_type" {
  type        = string
  description = "(Optional) Specify the OS type."
}

variable "public_portal_forward_proxy_vm_image_publisher" {
  type = string
}

variable "public_portal_forward_proxy_vm_image_offer" {
  type = string
}
variable "public_portal_forward_proxy_vm_image_sku" {
  type = string
}
variable "public_portal_forward_proxy_vm_image_version" {
  type = string
}
variable "public_portal_forward_proxy_vm_marketplace_name" {
  type = string
}
variable "public_portal_forward_proxy_vm_marketplace_publisher" {
  type = string
}
variable "public_portal_forward_proxy_vm_marketplace_product" {
  type = string
}

variable "public_portal_forward_proxy_vm_tls_private_key_file" {
  type        = string
  default     = null
  description = "(optional)Specify the filename with private key file for the Linux vm for ssh"
}

variable "public_portal_forward_proxy_dependencies" {
  type        = list
  description = "List of dependecies modules or resources"
  default     = null
}

#end region Virtual Machine

