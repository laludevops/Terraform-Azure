# management zone variables
variable "mz_zone_name" {}
variable "mz_zone_vnet_name" {}
variable "mz_tmt_zone_subnet_name" {}
variable "mz_tmt_zone_network_security_group_name" {}
variable "mz_db_zone_subnet_name" {}


# management zone tmt tier variables
variable "mz_tmt_tier_name" {}
variable "ad_ds_name" {}
variable "ad_ds_instance_count" {}
variable "ad_ds_size" {}
variable "ad_ds_fqdn" {}
variable "ad_ds_admin_username" {}
variable "ad_ds_admin_password" {}
variable "ad_ds_image" {}

variable "pano_name" {}
variable "pano_instance_count" {}
variable "pano_size" {}
variable "pano_fqdn" {}
variable "pano_admin_username" {}
variable "pano_admin_password" {}
variable "pano_image" {}

variable "wsus_name" {}
variable "wsus_lb_instance_count" {}
variable "wsusvm_size" {}
variable "wsus_fqdn" {}
variable "wsusadmin_username" {}
variable "wsus_admin_password" {}
variable "wsus_image" {}
variable "wsus_lb_rules" {}

variable "ca_name" {}
variable "ca_instance_count" {}
variable "ca_size" {}
variable "ca_fqdn" {}
variable "ca_admin_username" {}
variable "ca_admin_password" {}
variable "ca_image" {}

variable "new_name" {}
variable "new_instance_count" {}
variable "new_size" {}
variable "new_fqdn" {}
variable "new_admin_username" {}
variable "new_admin_password" {}
variable "new_image" {}


# management zone db tier variables
variable "mz_db_tier_name" {}
variable "wsus_server_sql_name" {}