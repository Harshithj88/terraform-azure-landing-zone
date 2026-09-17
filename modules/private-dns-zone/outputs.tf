output "id" {
  description = "Private DNS zone resource ID"
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  description = "Private DNS zone name"
  value       = azurerm_private_dns_zone.this.name
}

output "vnet_link_ids" {
  description = "Map of VNet link names to their resource IDs"
  value       = { for k, v in azurerm_private_dns_zone_virtual_network_link.links : k => v.id }
}
