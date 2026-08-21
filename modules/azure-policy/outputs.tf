output "require_env_tag_assignment_id" {
  description = "Policy assignment ID for environment tag requirement"
  value       = azurerm_subscription_policy_assignment.require_tags.id
}

output "require_owner_tag_assignment_id" {
  description = "Policy assignment ID for owner tag requirement"
  value       = azurerm_subscription_policy_assignment.require_owner_tag.id
}
