# Network Security Group Module

Deploys an Azure NSG with dynamic security rules and optional subnet association.

## Features

- Dynamic rule creation from a list of objects
- Input validation on direction, access, and protocol
- Optional subnet association
- Supports both single and multiple port ranges

## Usage

```hcl
module "nsg_web" {
  source = "../../modules/nsg"

  nsg_name            = "nsg-web-prod"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_ids          = [module.spoke_vnet.subnet_ids["web"]]

  security_rules = [
    {
      name                       = "Allow-HTTPS-Inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
    },
    {
      name                       = "Deny-All-Inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  tags = local.common_tags
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `nsg_name` | string | — | NSG name |
| `resource_group_name` | string | — | Resource group name |
| `location` | string | — | Azure region |
| `security_rules` | list(object) | `[]` | Security rule definitions |
| `subnet_ids` | list(string) | `[]` | Subnets to associate |
| `tags` | map(string) | `{}` | Tags |

## Outputs

| Name | Description |
|------|-------------|
| `id` | NSG resource ID |
| `name` | NSG name |
