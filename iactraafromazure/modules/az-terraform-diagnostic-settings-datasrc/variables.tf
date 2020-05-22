/*variable "diagnostics_map" {
  description = "(Required) contains the SA and EH details for operations diagnostics."
}
*/
variable "log_analytics_workspace_id" {
  description = "(Required) contains the log analytics workspace ID details for operations diagnostics."
}

# variable "resource_id" {
#   description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics." 
# }

variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = map(object({
      resource_id = list(string)
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    }))
}

variable "dependencies" {
  type = list
  description = "List of dependecies modules or resources"
  default     = null
}

# diag_object is a complex object describing the configuration of diagnostics logging for a component, as follows: 
# diag_object = {
#     log = [
#                 # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
#                 ["AzureBackupReport", true, true, 100],
#                 ["AzureSiteRecoveryJobs", true, true, 20],
#                 ["AzureSiteRecoveryEvents", true, true, 30],
#                 ["AzureSiteRecoveryReplicatedItems", true, true, 40],
#                 ["AzureSiteRecoveryReplicationStats", true, true, 50],
#                 ["AzureSiteRecoveryRecoveryPoints", true, true, 60],
#                 ["AzureSiteRecoveryReplicationDataUploadRate", true, true, 70],
#                 ["AzureSiteRecoveryProtectedDiskDataChurn", true, true, 80],
#         ]
#     metric = [
#                 #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
                  #["AllMetrics", 60, True],
#     ]
# }

variable "resource_type" {
  type = string
  description = "(Required) Specify the type of azure resource"
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              project_code  = string
              agency_code  = string
              env           =  string
              zone =  string 
              tier = string
    })
}

variable "tags" {
  type =  map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}
