# VM-FW-Azure-AZ-Existing-VNET
This Terraform template will deploy a VM-Series into an existing VNET in an Azure Availability Zone.


## Prequisites:
- The folliwing must be availabe before running this template:
  - Resource Group
  - VNET
    - Subnets for Management, Untrust and Trust Interfaces
  - Network Security Group (NSG) for the Management, Untrust and Trust subnets


## Prequisites (Software):
- Terraform version 0.12 or above
- Azure CLI v2.2.0 to login to Azure (if you are not using Service Principle)
  - Azure CLI is required in order to login to Corporate Azure via command line (az login)


## Description:
- Please enter the values of the following variables in the terraform.tfvars file before running the template
  - resource_group_name
    - The name of an existing resource group that is setup in an Azure location that supports Availability Zone
  - virtualNetworkName
    - The name of the Virtual Network to set up the VM-Series
  - zones
    - The Availability Zone to set up VM-Series
    - ["1"] or ["2"] or ["3"]
  - fwName
    - Hostname for the VM-Series
  - Mgmt-Subnet
    - The name of the Management subnet
  - Untrust-Subnet
    - The name of the Untrust subnet 
  - Trust-Subnet
    - The name of the Trust subnet 
  - accelerated_networking
    - yes/no
  - bootstrap
    - yes/no
  - customdata
    - If bootstrap is set to "yes", then a valid customdata for bootstrapping is required
  - adminUsername
    - The username to login to VM-Series
  - adminPassword
    - The password to login to VM-Series
    - The password must satisfy the PAN-OS password complexity requirements
- The following variables have default values set. You can use the default values or input your own
  - vmSize
    - The Azure instance type
  - imageSku
    - The VM-Series image SKU
  - imageVersion
    - The PAN-OS version
  - AllowedSourceIPRange
    - The allowed source IP range that is allowed to access VM-Series
- Please enter the values correctly as there is no error handling
- Please wait 20-30 minutes for the VM-Series to be fully functional


## Support Policy
The code and templates in the repo are released under an as-is, best effort,
support policy. These scripts should be seen as community supported and
Palo Alto Networks will contribute our expertise as and when possible.
We do not provide technical support or help in using or troubleshooting the
components of the project through our normal support options such as
Palo Alto Networks support teams, or ASC (Authorized Support Centers)
partners and backline support options. The underlying product used
(the VM-Series firewall) by the scripts or templates are still supported,
but the support is only for the product functionality and not for help in
deploying or using the template or script itself. Unless explicitly tagged,
all projects or work posted in our GitHub repository
(at https://github.com/PaloAltoNetworks) or sites other than our official
Downloads page on https://support.paloaltonetworks.com are provided under
the best effort policy.