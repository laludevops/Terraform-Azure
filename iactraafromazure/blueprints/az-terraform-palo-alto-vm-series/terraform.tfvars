resource_group_name = "<existing-resource-group-name>"
virtualNetworkName = "<existing-VNET-name>"
zones = ["1"] 
fwName = "VM-FW1"
Mgmt-Subnet = "Mgmt"
Untrust-Subnet = "Untrust"
Trust-Subnet = "Trust"
accelerated_networking = "yes"
vmSize = "Standard_DS3_v2"
imageSku = "byol"
imageVersion = "latest"
bootstrap = "no"
customdata = ""
adminUsername = "admin"
adminPassword = "<admin-password>"
AllowedSourceIPRange = "0.0.0.0/0"
