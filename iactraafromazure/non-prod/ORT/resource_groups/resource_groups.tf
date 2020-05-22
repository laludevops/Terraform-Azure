module "ort_resource_groups" {
  source = "../../../modules/az-terraform-resource-group"
  resource_groups = {
    tf = {
      name     = "rg_ort_storageaccount_terraformstate"
      location = "southeastasia"
      tags     = {}
    }
    flow_logs = {
      name     = "rg_ort_storageaccount_networkwatcher"
      location = "southeastasia"
      tags     = {}
    }
    kv = {
      name     = "rg_ort_keyvault"
      location = "southeastasia"
      tags     = {}
    }
    rsv = {
      name     = "rg_ort_backup"
      location = "southeastasia"
      tags     = {}
    }
    ez_ingress_egress = {
      name     = "rg_cmt-21090011_nsgasg"
      location = "southeastasia"
      tags     = {}
    }
    iz_ingress_egress = {
      name     = "rg_cmt-21090010_nsgasg"
      location = "southeastasia"
      tags     = {}
    }
    public = {
      name     = "rg_cmt-21090009_nsgasg"
      location = "southeastasia"
      tags     = {}
    }
    transit_hub = {
      name     = "rg_cmt-21090007_nsgasg"
      location = "southeastasia"
      tags     = {}
    }
  }
}
