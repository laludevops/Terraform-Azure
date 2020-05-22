
# dev ops zone aks tier variables
variable "common_devops_aks_resource_group_name" {}
variable "common_devops_aks_location" {}
variable "common_devops_aks_node_pool_name" {}
variable "common_devops_aks_vm_size" {}
variable "common_devops_aks_os_disk_size_gb" {}
variable "common_devops_aks_max_pods" {}
variable "common_devops_aks_availability_zones" {}
variable "common_devops_aks_enable_auto_scaling" {}
variable "common_devops_aks_min_count" {}
variable "common_devops_aks_max_count" {}


# dev ops zone app tier variables
variable "dz_app_tier_name" {}
variable "tosca_server_name" {}
variable "tosca_server_lb_instance_count" {}
variable "tosca_server_vm_size" {}
variable "tosca_server_fqdn" {}
variable "tosca_server_admin_username" {}
variable "tosca_server_admin_password" {}
variable "tosca_server_image" {}
variable "tosca_server_lb_rules" {}


# dev ops zone tmt tier variables
variable "dz_tmt_tier_name" {}
variable "fortify_ssc_name" {}
variable "fortify_ssc_lb_instance_count" {}
variable "fortify_ssc_vm_size" {}
variable "fortify_ssc_fqdn" {}
variable "fortify_ssc_admin_username" {}
variable "fortify_ssc_admin_password" {}
variable "fortify_ssc_image" {}
variable "fortify_ssc_lb_rules" {}

variable "fortify_wi_name" {}
variable "fortify_wi_instance_count" {}
variable "fortify_wi_vm_size" {}
variable "fortify_wi_fqdn" {}
variable "fortify_wi_admin_username" {}
variable "fortify_wi_admin_password" {}
variable "fortify_wi_image" {}

variable "build_vm_name" {}
variable "build_vm_instance_count" {}
variable "build_vm_size" {}
variable "build_vm_fqdn" {}
variable "build_vm_admin_username" {}
variable "build_vm_admin_password" {}
variable "build_vm_image" {}

variable "tosca_agent_name" {}
variable "tosca_agent_instance_count" {}
variable "tosca_agent_size" {}
variable "tosca_agent_fqdn" {}
variable "tosca_agent_admin_username" {}
variable "tosca_agent_admin_password" {}
variable "tosca_agent_image" {}

variable "tosca_connect_name" {}
variable "tosca_connect_instance_count" {}
variable "tosca_connect_size" {}
variable "tosca_connect_fqdn" {}
variable "tosca_connect_admin_username" {}
variable "tosca_connect_admin_password" {}
variable "tosca_connect_image" {}


# dev ops zone db tier variables
variable "dz_db_tier_name" {}
variable "tosca_server_sql_name" {}
variable "fortify_ssc_sql_name" {}
variable "postgres_sql_name" {}
