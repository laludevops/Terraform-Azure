## unable to create diagnostic settings for insights due to:
## "is not whitelisted in the private preview of diagnostic log settings for Azure resource type 'microsoft.insights/components', feature flag: 'microsoft.insights/diagnosticsettingpreview'."
# locals {
#     diag_object = {
#       insights = {
#         resource_id = [azurerm_application_insights.insight.id]
#         log         = var.diag_object.log
#         metric      = var.diag_object.metric
#       }
#     }
# }

# module "diagnostics" {
#   source  = "../az-terraform-diagnostic-settings-datasrc"

#   log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
#   diag_object                     = local.diag_object
#   naming_convention_info          = var.naming_convention_info
#   dependencies                    = [azurerm_application_insights.insight]
#   resource_type                   = "aidia" 
#   tags                            = var.tags
# }