# management zone settings
mz_zone_name                            = "cmn"
mz_zone_vnet_name                       = "v2-l2-mgmt-spoke-vnet-test"
mz_tmt_zone_subnet_name                 = "v2-l2-mgmt-spoke-snet-test"
mz_tmt_zone_network_security_group_name = "v2-l2-mgmt-spoke-nsg"
#mz_db_zone_subnet_name                  = "sub-gcc-dev-z1-web-s1-001"
resource_group_name = "v2-l2-mgmt-spoke-test"
location            = "southeastasia"
# management zone tmt tier settings
mz_tmt_tier_name     = "tmt"
ad_ds_name           = "ad"
ad_ds_instance_count = 2
ad_ds_size           = "Standard_D4s_v3"
ad_ds_fqdn           = "example"
ad_ds_admin_username = "admin123"
ad_ds_admin_password = "adMin%6541"
ad_ds_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}

naming_convention_info = {
  "agency_code"  = "iras"
  "project_code" = "irin"
  "env"          = "dv"
}
pano_name           = "pn"
pano_instance_count = 2
pano_size           = "Standard_D8s_v3"
pano_fqdn           = "example"
pano_admin_username = "admin123"
pano_admin_password = "adMin%6541"
pano_image = {
  publisher = "paloaltonetworks"
  offer     = "panorama"
  sku       = "byol"
  version   = "9.0.5"
}
pano_os_type                  = "linux"
palo_vm_marketplace_name      = "byol"
palo_vm_marketplace_publisher = "paloaltonetworks"
palo_vm_marketplace_product   = "panorama"
pano_asg_name                 = "pano_asg_test"
pano_managed_disk_name        = "pano_md"

fortify_ssc_name           = ""
fortify_ssc_instance_count = 1
fortify_ssc_size           = "Standard_D8s_v3"
fortify_ssc_fqdn           = "example"
fortify_ssc_admin_username = "admin123"
fortify_ssc_admin_password = "adMin%6541"
fortify_ssc_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}
fortify_os_type      = "Windows"
fortify_ssc_asg_name = "001"

wsus_name              = "ws"
wsus_lb_instance_count = 2
wsusvm_size            = "Standard_D4s_v3"
wsus_fqdn              = "example"
wsusadmin_username     = "admin123"
wsus_admin_password    = "adMin%6541"
wsus_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}
wsus_lb_rules = {
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

ca_name           = ""
ca_instance_count = 2
ca_size           = "Standard_D4s_v3"
ca_fqdn           = "example"
ca_admin_username = "admin123"
ca_admin_password = "adMin%6541"
ca_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}


new_name           = "ne"
new_instance_count = 1
new_size           = "Standard_D4s_v3"
new_fqdn           = "example"
new_admin_username = "admin123"
new_admin_password = "adMin%6541"
new_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}


# management zone db tier settings
mz_db_tier_name      = "db"
wsus_server_sql_name = "wsus"
