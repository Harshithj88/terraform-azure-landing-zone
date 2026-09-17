# Private DNS Zone Module

Deploys an Azure Private DNS Zone with VNet links and optional A records.

## Features

- Private DNS zone for private endpoint resolution
- Multiple VNet link support with optional auto-registration
- Static A record creation for custom entries

## Usage

```hcl
module "dns_blob" {
  source = "../../modules/private-dns-zone"

  zone_name           = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name

  vnet_links = [
    {
      name    = "hub-link"
      vnet_id = module.hub_vnet.id
    },
    {
      name                 = "spoke-link"
      vnet_id              = module.spoke_vnet.id
      registration_enabled = false
    }
  ]

  tags = local.common_tags
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `zone_name` | string | — | DNS zone name (e.g., `privatelink.blob.core.windows.net`) |
| `resource_group_name` | string | — | Resource group name |
| `vnet_links` | list(object) | `[]` | VNet links with name, vnet_id, registration_enabled |
| `a_records` | list(object) | `[]` | Static A records with name, records, ttl |
| `tags` | map(string) | `{}` | Tags |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Private DNS zone resource ID |
| `name` | Private DNS zone name |
| `vnet_link_ids` | Map of link names to resource IDs |
