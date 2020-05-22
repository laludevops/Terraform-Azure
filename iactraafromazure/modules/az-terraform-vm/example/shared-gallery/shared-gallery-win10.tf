locals {
  project_code = "irasgcc"
  env          = "dev"
  zone         = "z1"
  agency_code  = "iras"
  tier         = "web"
}


locals {
  resource_group_name = "rg-sri-iac"
  vnet_name           = "vnet-sri"
  location            = "southeastasia"
  naming_convention_info = {
    "name"         = "gl"
    "agency_code"  = local.agency_code
    "project_code" = local.project_code
    "env"          = local.env
    "zone"         = local.zone
    tier           = local.tier
  }
  tags    = {}
  loga_id = "/subscriptions/c6e005c4-b5a3-450d-af71-4732b55d4471/resourcegroups/rg-lz-iac/providers/microsoft.operationalinsights/workspaces/loga-irasgcc-dev-z1-web-mad-001"
}

data "azurerm_shared_image_version" "gallery_image" {
  name                = "1.0.3"
  image_name          = "windowsdevmachine01"
  gallery_name        = "irasdev_sharedimagegallery"
  resource_group_name = "rg-secteam-roniel"
}

data "azurerm_subnet" "example" {
  name                 = "snet-irasgcc-devz1web-s1"
  virtual_network_name = "vnet-iac-sri"
  resource_group_name  = local.resource_group_name
}

module "virtual_machine" {
  source              = "../../"
  location            = local.location
  resource_group_name = local.resource_group_name
  instance_count      = 1
  custom_image_id     = data.azurerm_shared_image_version.gallery_image.id
  
  nic_info = {
    subnet_id = data.azurerm_subnet.example.id
    nsg_id    = null
    nics = {
      "${local.naming_convention_info.name}" = {
        private_ip_address   = null
        is_primary           = true
        public_ip_address_id = null
      }
    }
  }
  vm_size                = "Standard_D4s_v3"
  admin_username         = "admin123"
  admin_password         = "adMin%6541"
  naming_convention_info = local.naming_convention_info
  disk_encryption_info   = null
  tags                   = {}
}
