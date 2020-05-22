variable "resource_group_name" {}

variable "location" {}

variable "publisher_name" {}

variable "publisher_email" {}

variable "sku_name" {
  description = "(Required) sku_name is a string consisting of two parts separated by an underscore(_). The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1)."
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type =  object({
              name          = string
              agency_code   = string
              project_code  = string
              env           =  string
              zone =  string 
              tier = string
    })
}

variable "tags" {
  description = "(optional) User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "certificate" {
  type = list(object({
    encoded_certificate   = string
    certificate_password  = string
    store_name            = string
  }))
  default = null
}

variable "additional_location" {
  type = list(object({
    location  = string
  }))
  default = null
}

variable "identity" {
  type = list(object({
    i_type  = string
  }))
  default = null
}

variable "hostname_configuration" {
  type = list(object({
    management  = list(object({
      host_name                      = string
      key_vault_id                  = string
      certificate                   = string
      certificate_password          = string
      negotiate_client_certificate  = bool
    }))

    portal  = list(object({
      host_name                      = string
      key_vault_id                  = string
      certificate                   = string
      certificate_password          = string
      negotiate_client_certificate  = bool
    }))

    scm  = list(object({
      host_name                      = string
      key_vault_id                  = string
      certificate                   = string
      certificate_password          = string
      negotiate_client_certificate  = bool
    }))

    proxy  = list(object({
      default_ssl_binding           = bool
      host_name                      = string
      key_vault_id                  = string
      certificate                   = string
      certificate_password          = string
      negotiate_client_certificate  = bool
    }))
  }))
  default = null
}

variable "notification_sender_email" {
  type = string
  default = null
}

variable "policy" {
  type = object({
    xml_content  = string
    xml_link     = string
  })
  default = null
}

variable "protocols" {
  type = object({
    enable_http2  = bool
  })
  default = null
}

variable "security" {
  type = object({
    enable_backend_ssl30        = bool
    enable_backend_tls10        = bool
    enable_backend_tls11        = bool
    enable_frontend_ssl30       = bool
    enable_frontend_tls10       = bool
    enable_frontend_tls11       = bool
    enable_triple_des_ciphers   = bool
    disable_backend_ssl30       = bool
    disable_backend_tls10       = bool
    disable_backend_tls11       = bool
    disable_frontend_ssl30      = bool
    disable_frontend_tls10      = bool
    disable_frontend_tls11      = bool
    disable_triple_des_ciphers  = bool
  })
  default = null
}

variable "sign_in" {
  type = object({
    enabled  = bool
  })
  default = null
}

variable "sign_up" {
  type = object({
    enabled  = bool
    terms_of_service = object({
      consent_required  = bool
      enabled           = bool
      text              = string
    })
  })
  default = null
}

variable "diag_object" {
  description = "(Required) Contains the diagnostics setting object." 
  type = object({
      log_analytics_workspace_id = string
      log         = list(tuple([string, bool, bool, number]))
      metric      = list(tuple([string, bool, bool, number]))
    })
}