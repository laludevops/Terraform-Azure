intranet_ingress_egress_asg_resource_group_name="rg_cmt-21090010_nsgasg"

intranet_lb_resource_group_name = "rg_ort_intranet_palo_alto"

intranet_palo_vm_instance_count = 2
intranet_palo_vm_size="Standard_DS3_v2"
intranet_palo_lb_sku="Standard"

intranet_ig_eg_palo_alto_name = "pa"

intranet_palo_vm_resource_group_name="rg_ort_intranet_palo_alto"
intranet_palo_vm_image_publisher="paloaltonetworks"
intranet_palo_vm_image_offer="vmseries1"
intranet_palo_vm_image_sku="byol"
intranet_palo_vm_image_version="latest"
intranet_palo_vm_marketplace_name="byol"
intranet_palo_vm_marketplace_publisher="paloaltonetworks"
intranet_palo_vm_marketplace_product="vmseries1"
intranet_palo_vm_admin_username="admin123"
intranet_palo_vm_admin_password="irasgcc@12345"
intranet_palo_vm_disable_password_authentication="true"
intranet_palo_vm_license_type=""
intranet_palo_vm_os_type="linux"
intranet_palo_vm_boot_diagnostics="true"

intranet_palo_lb_rules_probe_port="443"
intranet_palo_lb_rules_probe_protocol="Tcp"
intranet_palo_lb_rules_lb_port="80"
intranet_palo_lb_rules_backend_port="80"
intranet_palo_lb_rules_load_distribution="Default"
intranet_palo_lb_rules_idle_timeout_in_minutes="4"
intranet_palo_lb_public_ip_address_id=""
intranet_palo_lb_static_ip=""

intranet_ingress_egress_lb_name="v2lbpalo"
intranet_ingress_egress_pip_name="pippalo"

intranet_ig_eg_palo_alto_nic_trust_name = "eg"
intranet_ig_eg_palo_alto_nic_management_name = "tmt"
intranet_ig_eg_palo_alto_nic_untrust_name = "ig"

intranet_ig_eg_palo_alto_mgmt_asg_name="tmt"
intranet_ig_eg_palo_alto_untrust_asg_name="ig"
intranet_ig_eg_palo_alto_trust_asg_name="eg"
