locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z1"
  agency_code   = "iras"
  tier          =  "tmt"
}


locals {
  virtual_network_name                = "vnet-irasgcc-prd-dz-devops-001"
  resource_group_name = "rg-lz-iac"
  location = "southeastasia"
  naming_convention_info = {
              "name"             = "eg1"
              "agency_code"  =  local.agency_code
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = local.tier
          }
  tags = {}
  loga_workspace_name = "loga-irasgcc-dev-z4-web-lz-001"
  loga_resource_group_name = "rg-lz-iac"
}

data "azurerm_log_analytics_workspace" "loga_obj" {
  name                = local.loga_workspace_name
  resource_group_name = local.loga_resource_group_name
}


data "azurerm_subnet" "subnet_example" {
  name                 = "snet-irin-cmndzapp-0002"
  virtual_network_name = local.virtual_network_name
  resource_group_name  = local.resource_group_name
}

module "aks_example" {
    source                = "../"
    resource_group_name   = local.resource_group_name
    location              = local.location
    agent_pool_subnet_id  =  data.azurerm_subnet.subnet_example.id

    default_node_pool       = {
        name                = "default"
        vm_size             = "Standard_B4ms"
        os_disk_size_gb     = 50
        max_pods            = 30
        availability_zones  = [1, 2, 3]
        enable_auto_scaling = true
        min_count           = 1
        max_count           = 3
    }
    service_principal       = {
      client_id     = "d6a8e808-552c-4879-88aa-14496c2dd71a"
      client_secret = "8bbca819-5af7-481b-9228-0216ada437c8"
    }
    diag_object             = { 
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loga_obj.id
        log  = [["AllLogs", true, true, 80]]
         metric = [["AllMetrics", true, true, 80]]
    }
    naming_convention_info    = local.naming_convention_info
    tags                      = local.tags
}