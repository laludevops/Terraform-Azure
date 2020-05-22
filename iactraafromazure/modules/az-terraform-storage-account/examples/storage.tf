

locals {
  project_code = "irin"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "web"
}

locals {
  loga_workspace_name      = "loga-irasgcc-dev-z4-web-lz-001"
  loga_resource_group_name = "rg-lz-iac"

  resource_group_name = "rg-lz-iac"
  location            = "southeastasia"
  naming_convention_info = {
    "name"         = "zy"
    "project_code" = local.project_code
    agency_code    = "iras"
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags    = {}
  loga_id = data.azurerm_log_analytics_workspace.loga_obj.id
  diag_object = {
    log_analytics_workspace_id = local.loga_id
    log                        = []

    metric = [["AllMetrics", true, true, 80]]
  }
}

data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = local.loga_workspace_name
  resource_group_name = local.loga_resource_group_name
}


module "storage_example" {
  source              = "../"
  resource_group_name = local.resource_group_name
  location            = local.location
  kind                = "StorageV2"
  sku                 = "Standard_LRS"
  access_tier         = "Hot"
  assign_identity     = true
  containers = {
    lvl0 = {
      name        = "lvl0"
      access_type = "private"
    }
    lvl1 = {
      name        = "lvl1"
      access_type = "private"
    }
  }
  diag_object            = local.diag_object
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}

module "nw_storage_example" {
  source              = "../"
  resource_group_name = local.resource_group_name
  location            = local.location
  kind                = "StorageV2"
  sku                 = "Standard_LRS"
  access_tier         = "Hot"
  assign_identity     = true
  containers = {
    lvl0 = {
      name        = "lvl0"
      access_type = "private"
    }
    lvl1 = {
      name        = "lvl1"
      access_type = "private"
    }
  }
  diag_object            = local.diag_object
  naming_convention_info = merge(local.naming_convention_info, { "name" = "nw" })
  tags                   = local.tags
}

output "id" {
  value = module.storage_example.sst_output.id
}

output "nw_obj" {
  value = module.nw_storage_example.sst_output.id
}

output "container" {
  value = module.storage_example.cnt_output
}
