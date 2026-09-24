# Container Registry Module

Deploys an Azure Container Registry with security-hardened defaults.

## Features

- Admin user disabled by default (prefer RBAC / managed identity)
- Public network access disabled by default
- Content trust and untagged retention policies (Premium SKU)
- Optional geo-replication (Premium SKU)
- Zone redundancy (Premium SKU)
- Optional CanNotDelete management lock

## Usage

```hcl
module "acr" {
  source = "../../modules/container-registry"

  registry_name       = "acrmyappprod001"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"
  retention_days      = 30
  enable_delete_lock  = true

  geo_replications = [
    { location = "westus2" }
  ]

  tags = local.common_tags
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `registry_name` | string | — | Globally unique name (5-50 alphanumeric) |
| `resource_group_name` | string | — | Resource group name |
| `location` | string | — | Azure region |
| `sku` | string | `"Premium"` | Basic, Standard, or Premium |
| `admin_enabled` | bool | `false` | Enable admin user |
| `public_network_access_enabled` | bool | `false` | Allow public access |
| `zone_redundancy_enabled` | bool | `true` | Zone redundancy (Premium) |
| `retention_days` | number | `30` | Untagged manifest retention (Premium) |
| `geo_replications` | list(object) | `[]` | Geo-replication regions (Premium) |
| `enable_delete_lock` | bool | `false` | Enable CanNotDelete lock |
| `tags` | map(string) | `{}` | Tags |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Registry resource ID |
| `name` | Registry name |
| `login_server` | Login server FQDN |
| `admin_username` | Admin username (if enabled) |
| `admin_password` | Admin password (sensitive, if enabled) |
