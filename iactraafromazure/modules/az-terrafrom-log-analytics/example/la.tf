
locals {
  project_code  = "irasgcc" 
  env           = "dev" 
  zone          =  "z3"
  agency_code   = "iras"
}

locals {
    resource_group = "rg-lz-iac"
    common_tags = {}
}

module "law_example" {
    source = "../"
    resource_group = local.resource_group
    location = "southeastasia"
    sku = "Free"
    naming_convention_info = {
              "name"          =  "lz"
              "agency_code"  =  local.agency_code
              "project_code"  =  local.project_code
              "env"           =  local.env
              "zone"          =  local.zone
               tier            = "web"
          }

    tags = local.common_tags
    solution_plan_map = {
        ADAssessment = {
            "publisher" = "Microsoft"
            "product"   = "OMSGallery/ADAssessment"
        },
        ADReplication = {
            "publisher" = "Microsoft"
            "product"   = "OMSGallery/ADReplication"
        },
        AgentHealthAssessment = {
            "publisher" = "Microsoft"
            "product"   = "OMSGallery/AgentHealthAssessment"
        },
        DnsAnalytics = {
            "publisher" = "Microsoft"
            "product"   = "OMSGallery/DnsAnalytics"
        },
        KeyVaultAnalytics = {
            "publisher" = "Microsoft"
            "product"   = "OMSGallery/KeyVaultAnalytics"
        }
    }  
}

output "loga_output" {
    value = {
        name = module.law_example.loga_output.name
        id = module.law_example.loga_output.id
        workspace_id = module.law_example.loga_output.workspace_id
    }
}
# op_loga_output = {
#   "id" = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-sri-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-sri-001"
#   "name" = "loga-irasgcc-dev-z1-web-sri-001"
#   "workspace_id" = "9cb38752-c2e9-4f60-98a3-fad04a5b5fc1"
# }