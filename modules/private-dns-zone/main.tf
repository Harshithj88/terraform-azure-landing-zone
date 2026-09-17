resource "azurerm_private_dns_zone" "this" {
  name                = var.zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "links" {
  for_each = { for link in var.vnet_links : link.name => link }

  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.vnet_id
  registration_enabled  = lookup(each.value, "registration_enabled", false)
  tags                  = var.tags
}

resource "azurerm_private_dns_a_record" "records" {
  for_each = { for r in var.a_records : r.name => r }

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = lookup(each.value, "ttl", 300)
  records             = each.value.records
}
