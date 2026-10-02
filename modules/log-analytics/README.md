# Log Analytics Module

Provisions a Log Analytics workspace, optionally with the Container Insights solution for AKS monitoring.

## Features

- `PerGB2018` workspace with configurable retention and daily ingestion quota
- Optional Container Insights solution for AKS cluster and container metrics
- Sensitive primary shared key output for agent onboarding
- Tagging support

## Usage

```hcl
module "log_analytics" {
  source = "../../modules/log-analytics"

  workspace_name      = "law-landingzone-prod"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  retention_days      = 90
  daily_quota_gb      = 10

  enable_container_insights = true

  tags = local.common_tags
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `workspace_name` | string | — | Workspace name |
| `resource_group_name` | string | — | Resource group name |
| `location` | string | — | Azure region |
| `retention_days` | number | `30` | Data retention period in days |
| `daily_quota_gb` | number | `-1` | Daily ingestion cap in GB (`-1` = unlimited) |
| `enable_container_insights` | bool | `true` | Deploy the Container Insights solution |
| `tags` | map(string) | `{}` | Resource tags |

## Outputs

| Name | Description |
|------|-------------|
| `workspace_id` | Workspace resource ID |
| `workspace_name` | Workspace name |
| `primary_shared_key` | Primary shared key (sensitive) |

## Notes

- Set `daily_quota_gb` in non-production to cap costs; use `-1` only when you have budget alerts in place.
- The `primary_shared_key` is marked `sensitive`; avoid logging it or exposing it in plan output.
- Container Insights requires the workspace to exist first; this module handles ordering automatically.
