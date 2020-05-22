
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "kind" {
  type        = string
  default     = "StorageV2"
  description = "The kind of storage account. Supports BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
}

variable "sku" {
  type        = string
  default     = "Standard_RAGRS"
  description = "The SKU of the storage account."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "The access tier of the storage account."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Set to `true` to only allow HTTPS traffic, or `false` to disable it."
}

variable "assign_identity" {
  type        = bool
  default     = true
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
}

variable "containers" {
  type = map(object({
    name        = string
    access_type = string
  }))
  default     = {}
  description = "List of storage containers."
}


variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    agency_code  = string
    project_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dependencies" {
  type        = list
  description = "List of dependecies modules or resources"
  default     = null
}
