resource "azurerm_lb" "lb_obj" {
  name                = module.lb_name.naming_convention_output[var.naming_convention_info.name].names.0
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  frontend_ip_configuration {
    name                          = module.fe_name.naming_convention_output[var.naming_convention_info.name].names.0
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.static_ip == null || var.static_ip == "" ? "dynamic" : "static"
    private_ip_address            = var.static_ip
    public_ip_address_id          = var.public_ip_address_id
  }
  depends_on = [var.dependencies]
  tags       = module.lb_name.naming_convention_output[var.naming_convention_info.name].tags.0
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  resource_group_name = var.resource_group_name
  name                = module.be_name.naming_convention_output[var.naming_convention_info.name].names.0

  #This forces a destroy when adding a new lb --> loadbalancer_id     = lookup(azurerm_lb.lb, each.key)["id"]
  loadbalancer_id = azurerm_lb.lb_obj.id
  depends_on      = [azurerm_lb.lb_obj]
}


resource "azurerm_lb_probe" "lb_probe" {
  for_each            = var.lb_rules
  resource_group_name = var.resource_group_name
  name                = module.probe_name.naming_convention_output[each.key].names.0
  port                = each.value.probe_port
  protocol            = each.value.probe_protocol
  request_path        = each.value.probe_protocol == "Tcp" ? "" : each.value.request_path

  #This forces a destroy when adding a new lb --> loadbalancer_id     = lookup(azurerm_lb.lb_obj, each.value["lb_key"])["id"]
  depends_on      = [azurerm_lb.lb_obj]
  loadbalancer_id = azurerm_lb.lb_obj.id
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.lb_rules
  resource_group_name            = var.resource_group_name
  name                           = module.rule_name.naming_convention_output[each.key].names.0
  protocol                       = "Tcp"
  frontend_port                  = each.value.lb_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = module.fe_name.naming_convention_output[var.naming_convention_info.name].names.0
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend.id
  probe_id                       = azurerm_lb_probe.lb_probe[each.key].id
  load_distribution              = each.value.load_distribution
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes

  #This forces a destroy when adding a new lb --> loadbalancer_id     = lookup(azurerm_lb.lb_obj, each.value["lb_key"])["id"]
  depends_on      = [azurerm_lb.lb_obj]
  loadbalancer_id = azurerm_lb.lb_obj.id
}
