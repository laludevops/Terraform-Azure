variable "resource_groups" {
  description = "(Required) Map of the resource groups to create"
  type = map(object({
    name = string
    location = string
    tags = map(string)
    naming_convention_info= map(string)
  }))
}
