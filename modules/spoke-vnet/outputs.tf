output "vnet_id" {
  description = "Spoke VNet resource ID"
  value       = azurerm_virtual_network.spoke.id
}

output "vnet_name" {
  description = "Spoke VNet name"
  value       = azurerm_virtual_network.spoke.name
}

output "workload_subnet_id" {
  description = "Workload subnet ID"
  value       = azurerm_subnet.workload.id
}

output "private_endpoint_subnet_id" {
  description = "Private endpoints subnet ID"
  value       = azurerm_subnet.private_endpoints.id
}
