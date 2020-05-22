transit_hub_asg_resource_group_name="rg_cmt-21090007_nsgasg"

transit_hub_lb_resource_group_name = "rg_ort_transit_hub_palo_alto"

transit_hub_palo_vm_instance_count = 2
transit_hub_palo_vm_size="Standard_DS3_v2"
transit_hub_palo_lb_sku="Standard"

transit_hub_ig_eg_palo_alto_name = "pa"

transit_hub_palo_vm_resource_group_name="rg_ort_transit_hub_palo_alto"
transit_hub_palo_vm_image_publisher="paloaltonetworks"
transit_hub_palo_vm_image_offer="vmseries1"
transit_hub_palo_vm_image_sku="byol"
transit_hub_palo_vm_image_version="latest"
transit_hub_palo_vm_marketplace_name="byol"
transit_hub_palo_vm_marketplace_publisher="paloaltonetworks"
transit_hub_palo_vm_marketplace_product="vmseries1"
transit_hub_palo_vm_admin_username="admin123"
transit_hub_palo_vm_admin_password="irasgcc@12345"
transit_hub_palo_vm_disable_password_authentication="true"
transit_hub_palo_vm_license_type=""
transit_hub_palo_vm_os_type="linux"
transit_hub_palo_vm_boot_diagnostics="true"

transit_hub_palo_lb_rules_probe_port="443"
transit_hub_palo_lb_rules_probe_protocol="Tcp"
transit_hub_palo_lb_rules_lb_port="80"
transit_hub_palo_lb_rules_backend_port="80"
transit_hub_palo_lb_rules_load_distribution="Default"
transit_hub_palo_lb_rules_idle_timeout_in_minutes="4"
transit_hub_palo_lb_public_ip_address_id=""
transit_hub_palo_lb_static_ip=""

transit_hub_ingress_egress_lb_name="v2lbpalo"
transit_hub_ingress_egress_pip_name="pippalo"

transit_hub_ig_eg_palo_alto_nic_trust_name = "eg"
transit_hub_ig_eg_palo_alto_nic_management_name = "tmt"
transit_hub_ig_eg_palo_alto_nic_untrust_name = "ig"

transit_ig_eg_palo_alto_mgmt_asg_name="tmt"
transit_ig_eg_palo_alto_untrust_asg_name="ig"
transit_ig_eg_palo_alto_trust_asg_name="eg"
