output "id" {
  description = "Network Security Group resource ID"
  value       = azurerm_network_security_group.this.id
}

output "name" {
  description = "Network Security Group name"
  value       = azurerm_network_security_group.this.name
}
