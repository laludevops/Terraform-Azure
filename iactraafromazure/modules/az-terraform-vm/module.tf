# data "azurerm_image" "custom" {
#   count               = var.custom_image != null ? 1 : 0
#   name                = var.custom_image.name
#   resource_group_name = var.custom_image.resource_group_name
# }

# data "azurerm_shared_image_version" "gallery_image" {
#   count               = var.gallery_image != null ? 1 : 0
#   name                = var.gallery_image.version
#   image_name          = var.gallery_image.name
#   gallery_name        = var.gallery_image.gallery_name
#   resource_group_name = var.gallery_image.resource_group_name
# }

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  nic_output_map = { for k, v in module.nic_obj.nic_output : "${k}" => v }

  # custom_image_id = coalesce(lookup(data.azurerm_image.custom, "id", ""), lookup(data.azurerm_shared_image_version.gallery_image, "id", ""), "")
}

resource "azurerm_virtual_machine" "vm_obj" {
  count                            = var.instance_count
  name                             = element(module.vm_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
  location                         = var.location
  resource_group_name              = var.resource_group_name
  network_interface_ids            = var.nic_ids == null ? [lookup(lookup(local.nic_output_map, "${count.index}", {}), "id", "")] : element(var.nic_ids, count.index)
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false
  license_type                     = var.license_type
  depends_on                       = [var.dependencies, module.nic_obj]
  zones                            = [(count.index % 3) + 1]

  dynamic "storage_image_reference" {
    for_each = var.image == null ? [] : [1]

    content {
      publisher = var.image.publisher
      offer     = var.image.offer
      sku       = var.image.sku
      version   = var.image.version
    }
  }

  dynamic "storage_image_reference" {
    for_each = var.custom_image_id == null || var.custom_image_id == "" ? [] : [1]
    content {
      id = var.custom_image_id
    }
  }

  storage_os_disk {
    name              = element(module.ossst_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
    caching           = var.os_disk.caching
    os_type           = var.os_type
    create_option     = var.os_disk.create_option
    managed_disk_type = var.os_disk.type
  }
  primary_network_interface_id = var.nic_ids != null ? var.nic_ids[count.index][0] : lookup(lookup(local.nic_output_map, "${count.index}", {}), "id", "")

  os_profile {
    computer_name  = element(module.vm_name.naming_convention_output[var.naming_convention_info.name].names, count.index)
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  dynamic "os_profile_linux_config" {
    for_each = lower(var.os_type) == "linux" ? [1] : []

    content {
      disable_password_authentication = var.disable_password_authentication
      dynamic "ssh_keys" {
        for_each = var.disable_password_authentication ? [0] : [1]
        content {
          path     = "/home/${var.admin_username}/.ssh/authorized_keys"
          key_data = var.tls_private_key != null ? file(var.tls_private_key) : tls_private_key.ssh.public_key_openssh

        }
      }
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = lower(var.os_type) == "windows" ? [1] : []

    content {
      enable_automatic_upgrades = lookup(var.os_profile_windows_config, "enable_automatic_upgrades", true)
      provision_vm_agent        = lookup(var.os_profile_windows_config, "provision_vm_agent", true)
      timezone                  = lookup(var.os_profile_windows_config, "timezone", "")
    }
  }

  dynamic "plan" {
    for_each = var.marketplace != null && var.marketplace != {} ? [1] : []

    content {
      name      = var.marketplace.name
      publisher = var.marketplace.publisher
      product   = var.marketplace.product
    }
  }

  # boot_diagnostics {
  #   enabled     = var.boot_diagnostics
  #   storage_uri = var.boot_diagnostics == true ? azurerm_storage_account.storage_account.primary_blob_endpoint : ""
  # }

  identity {
    type         = var.managedidentity_type
    identity_ids = var.managedidentity_ids
  }

  tags = element(module.vm_name.naming_convention_output[var.naming_convention_info.name].tags, count.index)
}
