# dev ops zone settings
dz_name                                 = "dz"
dz_zone_vnet_name                       = "terraform-test-vnet"
dz_tmt_zone_subnet_name                 = "sub-gcc-dev-z1-web-s1-001"
dz_tmt_zone_network_security_group_name = "nsg-gcc-dev-z1-web-s1-001"
dz_aks_zone_subnet_name                 = "sub-gcc-dev-z1-web-s1-001"
dz_app_zone_subnet_name                 = "sub-gcc-dev-z1-web-s1-001"
dz_app_zone_network_security_group_name = "nsg-gcc-dev-z1-web-s1-001"
dz_db_zone_subnet_name                  = "sub-gcc-dev-z1-web-s1-001"

# dev ops zone aks tier settings
dz_aks_tier_name        = "aks"
aks_build_name          = "build"
aks_node_pool_name      = "default"
aks_vm_size             = "Standard_D2s_v3"
aks_os_disk_size_gb     = 50
aks_max_pods            = 30
aks_availability_zones  = [1, 2, 3]
aks_enable_auto_scaling = true
aks_min_count           = 3
aks_max_count           = 3
aks_service_principal = {
  client_id     = "8d710125-e02c-47c6-ad80-6d9995db3d94"
  client_secret = "T_y239m1y]FeDXk_[JI_C2zz4tTqWRtD"
}

# dev ops zone app tier settings
dz_app_tier_name               = "app"
tosca_server_name              = "ts"
tosca_server_lb_instance_count = 2
tosca_server_vm_size           = "Standard_D4s_v3"
tosca_server_fqdn              = "example"
tosca_server_admin_username    = "admin123"
tosca_server_admin_password    = "adMin%6541"
tosca_server_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}
tosca_server_lb_rules = {
  rule_one = {
    probe_port              = "80"
    probe_protocol          = "Tcp"
    lb_port                 = "80"
    backend_port            = "80"
    load_distribution       = "Default"
    idle_timeout_in_minutes = 4
    request_path            = "/"
  }
}

# dev ops zone tmt tier settings
dz_tmt_tier_name              = "tmt"
fortify_ssc_name              = "sc"
fortify_ssc_lb_instance_count = 2
fortify_ssc_vm_size           = "Standard_D4s_v3"
fortify_ssc_fqdn              = "example"
fortify_ssc_admin_username    = "admin123"
fortify_ssc_admin_password    = "adMin%6541"
fortify_ssc_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}
fortify_ssc_lb_rules = {
  rule_one = {
    probe_port              = "80"
    probe_protocol          = "Tcp"
    lb_port                 = "80"
    backend_port            = "80"
    load_distribution       = "Default"
    idle_timeout_in_minutes = 4
    request_path            = "/"
  }
}

fortify_wi_name           = "wi"
fortify_wi_instance_count = 1
fortify_wi_vm_size        = "Standard_D4s_v3"
fortify_wi_fqdn           = "example"
fortify_wi_admin_username = "admin123"
fortify_wi_admin_password = "adMin%6541"
fortify_wi_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}

build_vm_name           = "bu"
build_vm_instance_count = 10
build_vm_size           = "Standard_D4s_v3"
build_vm_fqdn           = "example"
build_vm_admin_username = "admin123"
build_vm_admin_password = "adMin%6541"
build_vm_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}

tosca_agent_name           = "ta"
tosca_agent_instance_count = 5
tosca_agent_size           = "Standard_D4s_v3"
tosca_agent_fqdn           = "example"
tosca_agent_admin_username = "admin123"
tosca_agent_admin_password = "adMin%6541"
tosca_agent_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}

tosca_connect_name           = "tc"
tosca_connect_instance_count = 1
tosca_connect_size           = "Standard_D4s_v3"
tosca_connect_fqdn           = "example"
tosca_connect_admin_username = "admin123"
tosca_connect_admin_password = "adMin%6541"
tosca_connect_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}


# dev ops zone db tier settings
dz_db_tier_name       = "db"
tosca_server_sql_name = "tosca"
fortify_ssc_sql_name  = "fortify"
postgres_sql_name     = "xxx"