# module "caf_name_apim" {
#   source  = "../az-terraform-caf-naming"
    
#   name    = var.app_name
#   type    = "apim"
#   convention  = var.naming_convention
# }


resource "azurerm_api_management" "api_management" {
  name                = module.apim_resource_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name = var.resource_group_name
  location            = var.location
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  tags                = module.apim_resource_name.naming_convention_output[var.naming_convention_info.name].tags.0
  sku_name            = var.sku_name
  notification_sender_email = var.notification_sender_email

    dynamic "additional_location"{
      for_each = var.additional_location != null ? [var.additional_location] : []

      content {
        location = additional_location.value.location
      }
    }
  
    dynamic "certificate" {
      for_each = var.certificate != null ? [var.certificate] : []

      content {
        encoded_certificate   =  certificate.value.encoded_certificate
        certificate_password  =  certificate.value.certificate_password
        store_name            =  certificate.value.store_name
      }
    }

    dynamic "identity" {
      for_each = var.identity != null ? [1] : []

      content {
        type = var.i_type
      }
    }

    dynamic "hostname_configuration" {
      for_each = var.hostname_configuration != null ? [1] : []

      content {
        dynamic "management" {
          for_each = hostname_configuration.value.management != null ? [hostname_configuration.value.management] : []

          content {
            host_name             = management.value.host_name
            key_vault_id          = management.value.key_vault_id
            certificate           = management.value.certificate
            certificate_password  = management.value.certificate_password
            negotiate_client_certificate = management.value.negotiate_client_certificate
          }
        }
        dynamic "portal" {
          for_each = hostname_configuration.value.portal != null ? [hostname_configuration.value.portal] : []

          content {
            host_name             = portal.value.host_name
            key_vault_id          = portal.value.key_vault_id
            certificate           = portal.value.certificate
            certificate_password  = portal.value.certificate_password
            negotiate_client_certificate = portal.value.negotiate_client_certificate
          }
        }       
        dynamic "scm" {
          for_each = hostname_configuration.value.scm != null ? [hostname_configuration.value.scm] : []

          content {
            host_name             = scm.value.host_name
            key_vault_id          = scm.value.key_vault_id
            certificate           = scm.value.certificate
            certificate_password  = scm.value.certificate_password
            negotiate_client_certificate = scm.value.negotiate_client_certificate
          }
        }        
        dynamic "proxy" {
          for_each = hostname_configuration.value.proxy != null ? [hostname_configuration.value.proxy] : []

          content {
            default_ssl_binding   = proxy.value.default_ssl_binding
            host_name             = proxy.value.host_name
            key_vault_id          = proxy.value.key_vault_id
            certificate           = proxy.value.certificate
            certificate_password  = proxy.value.certificate_password
            negotiate_client_certificate = proxy.value.negotiate_client_certificate
          }
        }      
      }
    }
  dynamic "policy" {
    for_each = var.policy != null ? [1] : []

    content {
      xml_content = var.policy.xml_content
      xml_link    = var.policy.xml_link
    }
  }

  dynamic "protocols" {
    for_each = var.protocols != null ? [1] : []

    content {
      enable_http2 = var.protocols.enable_http2
    }
  }

  dynamic "security" {
    for_each = var.security != null ? [1] : []

    content {
      enable_backend_ssl30        = var.security.enable_backend_ssl30
      enable_backend_tls10        = var.security.enable_backend_tls10
      enable_backend_tls11        = var.security.enable_backend_tls11
      enable_frontend_ssl30       = var.security.enable_frontend_ssl30
      enable_frontend_tls10       = var.security.enable_frontend_tls10
      enable_frontend_tls11       = var.security.enable_frontend_tls11
      enable_triple_des_ciphers   = var.security.enable_triple_des_ciphers
      disable_backend_ssl30       = var.security.disable_backend_ssl30
      disable_backend_tls10       = var.security.disable_backend_tls10
      disable_backend_tls11       = var.security.disable_backend_tls11
      disable_frontend_ssl30      = var.security.disable_frontend_ssl30
      disable_frontend_tls10      = var.security.disable_frontend_tls10
      disable_frontend_tls11      = var.security.disable_frontend_tls11
      disable_triple_des_ciphers  = var.security.disable_triple_des_ciphers
    }
  }

  dynamic "sign_in" {
    for_each = var.sign_in != null ? [1] : []

    content {
      enabled = var.sign_in.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.sign_up != null ? [1] : []

    content {
      enabled          = var.sign_up.enabled
      dynamic "terms_of_service" {
        for_each = var.sign_up.terms_of_service != null ? [1] : []

        content {
          consent_required  = var.sign_up.terms_of_service.consent_required
          enabled           = var.sign_up.terms_of_service.enabled
          text              = var.sign_up.terms_of_service.text
        }
      }
    }
  }
}
