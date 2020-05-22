#ASG related ##################
variable "internet_ingress_egress_asg_resource_group_name" {
  type        = string
}
#end region ASG related 

# Load Balancer Related ##################
variable "internet_lb_resource_group_name" {
  type        = string
}

variable "internet_ig_eg_palo_alto_name" {
  
}

variable "internet_ingress_egress_lb_name" {
  description = "(Required) Load balancer name"
  type        = string
}

variable "internet_ingress_egress_pip_name" {
  description = "(Required) PIP Load balancer name"
  type        = string
}


variable "internet_palo_lb_public_ip_address_id" {
  description = "Public Ip Address for the load balancer"
  type        = string
}

variable "internet_palo_lb_static_ip" {
  description = "Static ip of the frontend config"
  type        = string
}


variable "internet_palo_lb_rules_probe_port" {
  type = string
}
variable "internet_palo_lb_rules_probe_protocol" {
  type = string
}
variable "internet_palo_lb_rules_lb_port" {
  type = string
}
variable "internet_palo_lb_rules_backend_port" {
  type = string
}
variable "internet_palo_lb_rules_load_distribution" {
  type = string
}
variable "internet_palo_lb_rules_idle_timeout_in_minutes" {
  type = string
}



variable "internet_palo_lb_sku" {
  description = "The SKU of Azure Load Balancer. Accepted values are only Standard"
  type        = string
}


#end region Load balancer

# Virtual Machine Related ##################
variable "internet_palo_vm_resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}


variable "internet_palo_vm_instance_count" {
  type        = number
  description = "(Optional) Specifies the number of the Virtual Machines. Minimum 2 for vm with load balancer."
}
variable "internet_palo_vm_admin_username" {
  type        = string
  description = "(Required) Specifies the user name of the Virtual Machine."
}
variable "internet_palo_vm_admin_password" {
  type        = string
  description = "(Required) Specifies the user password of the Virtual Machine."
}
variable "internet_palo_vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the Virtual Machine."
}

variable "internet_palo_vm_disable_password_authentication" {
  type        = bool
  description = "(Optional) Disable passwords authentication"
}

variable "internet_palo_vm_license_type" {
  type        = string
  description = "(Optional) Specify the BYOL license type."
}

variable "internet_palo_vm_os_type" {
  type        = string
  description = "(Optional) Specify the OS type."
}

variable "internet_palo_vm_image_publisher" {
  type = string
}

variable "internet_palo_vm_image_offer" {
  type = string
}
variable "internet_palo_vm_image_sku" {
  type = string
}
variable "internet_palo_vm_image_version" {
  type = string
}
variable "internet_palo_vm_boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
}

variable "internet_palo_vm_marketplace_name" {
  type = string
}
variable "internet_palo_vm_marketplace_publisher" {
  type = string
}
variable "internet_palo_vm_marketplace_product" {
  type = string
}


#end region Virtual Machine

# NIC Related ##################

variable "internet_ig_eg_palo_alto_nic_trust_name" {
  
}

variable "internet_ig_eg_palo_alto_nic_untrust_name" {
  
}
variable "internet_ig_eg_palo_alto_nic_management_name" {
  
}


#end region NIC 


#region Egress Load Balancer
variable "internet_ingress_egress_lb_rules_probe_port" {
  type = string
}
variable "internet_ingress_egress_lb_rules_probe_protocol" {
  type = string
}
variable "internet_ingress_egress_lb_rules_lb_port" {
  type = string
}
variable "internet_ingress_egress_lb_rules_backend_port" {
  type = string
}
variable "internet_ingress_egress_lb_rules_load_distribution" {
  type = string
}
variable "internet_ingress_egress_lb_rules_idle_timeout_in_minutes" {
  type = string
}

variable "internet_ingress_egress_lb_public_ip_address_id" {
  description = "Public Ip Address for the load balancer"
  type        = string
}

variable "internet_ingress_egress_lb_static_ip" {
  description = "Static ip of the frontend config"
  type        = string
}

#end region
variable "internet_ig_eg_palo_alto_management_asg_name" {
  type        = string
}
variable "internet_ig_eg_palo_alto_trust_asg_name" {
  type        = string
}
variable "internet_ig_eg_palo_alto_untrust_asg_name" {
  type        = string
}