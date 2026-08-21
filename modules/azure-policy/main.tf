resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  count                = var.management_group_id != "" ? 1 : 0
  name                 = "allowed-locations"
  display_name         = "Allowed Locations"
  description          = "Restrict resource deployment to approved Azure regions"
  management_group_id  = var.management_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

resource "azurerm_subscription_policy_assignment" "require_tags" {
  name                 = "require-env-tag"
  display_name         = "Require environment tag on resource groups"
  description          = "Enforce the 'environment' tag on all resource groups"
  subscription_id      = var.subscription_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"

  parameters = jsonencode({
    tagName = {
      value = "environment"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "require_owner_tag" {
  name                 = "require-owner-tag"
  display_name         = "Require owner tag on resource groups"
  description          = "Enforce the 'owner' tag on all resource groups"
  subscription_id      = var.subscription_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"

  parameters = jsonencode({
    tagName = {
      value = "owner"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "deny_public_ip" {
  count                = var.deny_public_ip ? 1 : 0
  name                 = "deny-public-ip"
  display_name         = "Deny Public IP addresses"
  description          = "Prevent creation of Public IP resources"
  subscription_id      = var.subscription_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
}

resource "azurerm_subscription_policy_assignment" "allowed_vm_skus" {
  count                = length(var.allowed_vm_skus) > 0 ? 1 : 0
  name                 = "allowed-vm-skus"
  display_name         = "Allowed VM SKUs"
  description          = "Restrict VM sizes to approved SKUs for cost control"
  subscription_id      = var.subscription_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"

  parameters = jsonencode({
    listOfAllowedSKUs = {
      value = var.allowed_vm_skus
    }
  })
}
