# Storage Account Module

Deploys an Azure Storage Account with security-hardened defaults.

## Features

- TLS 1.2 minimum enforced
- Public blob access disabled
- Blob versioning and soft-delete enabled
- Network rules with deny-all default
- Optional container creation
- Optional CanNotDelete management lock
- RBAC-only access (shared keys disabled by default)

## Usage

```hcl
module "storage" {
  source = "../../modules/storage-account"

  storage_account_name   = "stmyappprod001"
  resource_group_name    = azurerm_resource_group.this.name
  location               = azurerm_resource_group.this.location
  replication_type       = "GRS"
  containers             = ["data", "logs", "backups"]
  allowed_subnet_ids     = [module.spoke_vnet.subnet_ids["app"]]
  enable_delete_lock     = true

  tags = local.common_tags
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `storage_account_name` | string | — | Globally unique name (3-24 lowercase alphanumeric) |
| `resource_group_name` | string | — | Resource group name |
| `location` | string | — | Azure region |
| `account_tier` | string | `"Standard"` | Standard or Premium |
| `replication_type` | string | `"LRS"` | LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS |
| `shared_access_key_enabled` | bool | `false` | Enable shared access keys |
| `versioning_enabled` | bool | `true` | Enable blob versioning |
| `soft_delete_retention_days` | number | `30` | Soft-delete retention |
| `network_default_action` | string | `"Deny"` | Default network rule |
| `allowed_subnet_ids` | list(string) | `[]` | Allowed subnet IDs |
| `allowed_ip_ranges` | list(string) | `[]` | Allowed IP ranges |
| `containers` | list(string) | `[]` | Blob containers to create |
| `enable_delete_lock` | bool | `false` | Enable CanNotDelete lock |
| `tags` | map(string) | `{}` | Tags |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Storage account resource ID |
| `name` | Storage account name |
| `primary_blob_endpoint` | Primary blob endpoint URL |
| `primary_access_key` | Primary access key (sensitive) |
