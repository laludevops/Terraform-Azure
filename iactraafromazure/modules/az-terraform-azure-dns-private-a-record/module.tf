resource "azurerm_private_dns_a_record" "private_dns_a_record_obj" {
  for_each = var.a_records

  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  name                = each.value.a_record_name
  records             = each.value.ips
  tags                = merge(module.private_dns_a_record.naming_convention_output[each.key].tags.0, { Name = each.value.a_record_name })
}
