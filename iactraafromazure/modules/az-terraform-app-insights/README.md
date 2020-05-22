# Creates one or multiple resource groups



Reference the module to a specific version (recommended):
```
module "resource_groups" {
    source                  = "git://github.com/aztfmod/resource_group.git?ref=v1.1"
  
    prefix                  = "${var.prefix}"
    resource_groups         = "${var.resource_groups}"
    location                = "${var.location_map["region1"]}"
    tags                    = "${var.tags}"
}
```

Or get the latest version
```
module "resource_groups" {
    source                  = "git://github.com/aztfmod/resource_group.git?ref=latest"
  
    prefix                  = "${var.prefix}"
    resource_groups         = "${var.resource_groups}"
    location                = "${var.location_map["region1"]}"
    tags                    = "${var.tags}"
}
```

# Parameters

## resource_groups
(Required) Map of the resource groups to create
```
variable "resource_groups" {
    description = "(Required) Map of the resource groups to create"
    type = "map"
}

```
Example
```
resource_groups {
    "networking"      = "AKS-CLUSTER-NETWORKING"
    "security"        = "AKS-CLUSTER-SECURITY"
}
```

## location
(Required) Define the region where the resource groups will be created
```

variable "location" {
    description = "(Required) Define the region where the resource groups will be created"
}
```
Example
```
location_map {
    "region1"    = "southeastasia"
    "region2"    = "eastasia"
}
```

## prefix
(Optional) You can use a prefix to add to the list of resource groups you want to create
```
variable "prefix" {
    description = "(Optional) You can use a prefix to add to the list of resource groups you want to create"
}
```
Example
```
locals {
    prefix = "${random_string.prefix.result}-"
}

resource "random_string" "prefix" {
    length  = 4
    upper   = false
    special = false
}
```

# Output
## names
Returns a map of:
- key   = "${keys(var.resource_groups)}"
- value = name of the resource group

## ids
Returns a map of:
- key   = "${keys(var.resource_groups)}"
- value = id of the resource group