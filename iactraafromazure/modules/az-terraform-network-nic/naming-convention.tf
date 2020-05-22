module "nic_name" {
  source      = "../az-terraform-naming-convention"
  name_format = "res_type|env|zone|tier|name|instance"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
      name_info = merge(var.naming_convention_info, { instance_count = var.instance_count })
      tags      = var.tags
    }
  }
  resource_type = "nic"
}

locals {
  nic_info = var.nic_info == null ? {} : var.nic_info
}

module "ipconfig_name" {
  source      = "../az-terraform-naming-convention"
  name_format = "res_type|-|env|-|zone|-|tier|-|name|-|instance"
  naming_convention_info = {
    for key, value in local.nic_info :
    "${key}" => {
      name_info = merge(var.naming_convention_info, {
        name           = key
        instance_count = var.instance_count
      })
      tags = var.tags
    }
  }
  resource_type = "ipcf"
}

