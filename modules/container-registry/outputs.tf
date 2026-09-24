output "id" {
  description = "Container registry resource ID"
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Container registry name"
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Container registry login server FQDN"
  value       = azurerm_container_registry.this.login_server
}

output "admin_username" {
  description = "Admin username (only populated when admin_enabled is true)"
  value       = var.admin_enabled ? azurerm_container_registry.this.admin_username : null
}

output "admin_password" {
  description = "Admin password (only populated when admin_enabled is true)"
  value       = var.admin_enabled ? azurerm_container_registry.this.admin_password : null
  sensitive   = true
}
