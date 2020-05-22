# Module
Creates a subnet with IRIN-3 naming convention scheme.

## Info
1. Provider version - 1.38

## Subnet map Properties
1. name
2. cidr
3. service_endpoints - array 
4. enforce_private_link_endpoint_network_policies
5. enforce_private_link_service_network_policies
7. delegation
    1. name
    2. service_delegation - https://www.terraform.io/docs/providers/azurerm/r/subnet.html#service_delegation



## Diagnostic Events
No events/logs emitted are supported - see NSG for events & metrics

## Naming convention
<resource-type>-<projectcode>-<environment>-<zone>-<tier>-<custom_name>-<instance-no>
eg. sub-irasgcc-prd-mz-tmt-adds0000-001

## Enhancements
1. NA


## Roles
Action | Name
-------|-----
Microsoft.Network/virtualNetworks/subnets/read | Read a virtual network subnet
Microsoft.Network/virtualNetworks/subnets/write | Create or update a virtual network subnet
Microsoft.Network/virtualNetworks/subnets/delete | Delete a virtual network subnet
Microsoft.Network/virtualNetworks/subnets/join/action | Join a virtual network
Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action | Enable a service endpoint for a subnet
Microsoft.Network/virtualNetworks/subnets/virtualMachines/read | Get the virtual machines in a subnet


Note:

Write the roles for each tf commoand *Tf init, tf plan, tf apply , add link but dont copy roleshr