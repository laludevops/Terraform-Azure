module "common_resource_groups" {
  source = "../../modules/az-terraform-resource-group"
  resource_groups = {
    tf = {
      name     = "rg_common_storageaccount_terraformstate"
      location = "southeastasia"
      tags     = {}
    }
    flow_logs = {
      name     = "rg_common_storageaccount_networkwatcher"
      location = "southeastasia"
      tags     = {}
    }
    kv = {
      name     = "rg_common_keyvault"
      location = "southeastasia"
      tags     = {}
    }
    rsv = {
      name     = "rg_common_backup"
      location = "southeastasia"
      tags     = {}
    }
    "developer_spoke" = {
      name     = "rg_cmt-20190008_nsgasg"
      location = "southeastasia"
      tags     = {}
    }
    "management_spoke" = {
      name     = "rg_cmt-20190012_nsgasg"
      location = "southeastasia"
      tags     = {}
    }
    "devops_spoke" = {
      name     = "rg_cmt-20190016_nsgasg"
      location = "southeastasia"
      tags     = {}
    } 
    "rg_common_mgmt_tmt_adds" = {
      name     = "rg_common_mgmt_tmt_adds"
      location = "southeastasia"
      tags     = {}
    }
    
  }
}
