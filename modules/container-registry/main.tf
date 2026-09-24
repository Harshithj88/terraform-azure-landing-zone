resource "azurerm_container_registry" "this" {
  name                          = var.registry_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  zone_redundancy_enabled       = var.sku == "Premium" ? var.zone_redundancy_enabled : false

  dynamic "georeplications" {
    for_each = var.sku == "Premium" ? var.geo_replications : []
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = lookup(georeplications.value, "zone_redundancy_enabled", true)
      tags                    = var.tags
    }
  }

  dynamic "retention_policy" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      enabled = true
      days    = var.retention_days
    }
  }

  dynamic "trust_policy" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      enabled = true
    }
  }

  tags = var.tags
}

resource "azurerm_management_lock" "this" {
  count      = var.enable_delete_lock ? 1 : 0
  name       = "${var.registry_name}-lock"
  scope      = azurerm_container_registry.this.id
  lock_level = "CanNotDelete"
  notes      = "Prevents accidental deletion of the container registry"
}
