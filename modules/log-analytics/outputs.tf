output "workspace_id" {
  description = "Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.law.id
}

output "workspace_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.law.name
}

output "primary_shared_key" {
  description = "Primary shared key (sensitive)"
  value       = azurerm_log_analytics_workspace.law.primary_shared_key
  sensitive   = true
}
