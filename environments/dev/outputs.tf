output "hub_vnet_id" {
  description = "Hub VNet ID"
  value       = module.hub_vnet.vnet_id
}

output "spoke_vnet_id" {
  description = "Spoke VNet ID"
  value       = module.spoke_vnet.vnet_id
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.key_vault.key_vault_uri
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = module.log_analytics.workspace_id
}
