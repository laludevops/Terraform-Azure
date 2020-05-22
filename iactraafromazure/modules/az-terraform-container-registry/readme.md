# Azure container registry Module
    Creates acr with diagnostic events and naming convention scheme

# acr properties
* resource_group
* location
* sku - Basic, Standard and Premium
* virtual_network  = [["allow", "subnet_id"]]


## Diagnostic Events
* ContainerRegistryLoginEvents - Registry authentication events and status, including the incoming identity and IP address
* ContainerRegistryRepositoryEvents - Operations such as push and pull for images and other artifacts in registry repositories
* [Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcontainerregistryregistries)
## Naming convention
<resource-type>-<projectcode>-<environment>-<zone>-<tier>-<custom_name>-<instance-no>
eg. acr-irasgcc-prd-mz-tmt-adds0000-001

## Enhancements
1. NA

## Roles
[ACR roles](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcontainerregistryregistries)