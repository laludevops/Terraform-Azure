locals {
  parameters_body = {
    aseName = {
      value = module.ase_arm_name.naming_convention_output[var.naming_convention_info.name].names.0
    },
    location = {
      value = var.location
    },
    kind = {
      value = var.kind
    },
    internalLoadBalancingMode = {
      value = var.internalLoadBalancingMode
    },
    vnet_id = {
      value = var.vnet_id
    },
    subnet = {
      value = var.subnet_name
    },
    aseResourceGroupName = {
      value = var.resource_group_name
    },
    tags = {
      value = module.ase_arm_name.naming_convention_output[var.naming_convention_info.name].tags.0
    }
  }
}

resource "azurerm_template_deployment" "ase" {

  name                = module.ase_arm_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name = var.resource_group_name

  template_body = file("${path.module}/arm_ase_isolated.json")

  parameters = {
    "aseName"                   = module.ase_arm_name.naming_convention_output[var.naming_convention_info.name].names.0
    "aseResourceGroupName"      = var.resource_group_name
    "location"                  = var.location
    "kind"                      = var.kind
    "vnet_id"                   = var.vnet_id
    "internalLoadBalancingMode" = var.internalLoadBalancingMode
    "subnet"                    = var.subnet_name
  }

  # parameters_body = jsonencode({
  # "tags" = module.ase_arm_name.naming_convention_output[var.naming_convention_info.name].tags.0 })

  deployment_mode = "Incremental"
}
