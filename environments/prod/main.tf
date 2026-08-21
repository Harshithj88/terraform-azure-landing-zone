terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "hub" {
  name     = "rg-hub-${var.environment}-${var.location_short}"
  location = var.location
  tags     = local.tags
}

resource "azurerm_resource_group" "spoke" {
  name     = "rg-spoke-${var.environment}-${var.location_short}"
  location = var.location
  tags     = local.tags
}

locals {
  tags = {
    environment = var.environment
    project     = "landing-zone"
    managed_by  = "terraform"
    owner       = var.owner
  }
}

module "log_analytics" {
  source              = "../../modules/log-analytics"
  workspace_name      = "law-${var.environment}-${var.location_short}"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  retention_days      = var.log_retention_days
  tags                = local.tags
}

module "hub_vnet" {
  source              = "../../modules/hub-vnet"
  vnet_name           = "vnet-hub-${var.environment}-${var.location_short}"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = [var.hub_address_space]
  gateway_subnet_prefix  = var.hub_gateway_subnet_prefix
  firewall_subnet_prefix = var.hub_firewall_subnet_prefix
  bastion_subnet_prefix  = var.hub_bastion_subnet_prefix
  enable_bastion      = var.enable_bastion
  tags                = local.tags
}

module "spoke_vnet" {
  source                         = "../../modules/spoke-vnet"
  vnet_name                      = "vnet-spoke-${var.environment}-${var.location_short}"
  location                       = var.location
  resource_group_name            = azurerm_resource_group.spoke.name
  address_space                  = [var.spoke_address_space]
  workload_subnet_prefix         = var.spoke_workload_subnet_prefix
  private_endpoint_subnet_prefix = var.spoke_private_endpoint_subnet_prefix
  hub_vnet_id                    = module.hub_vnet.vnet_id
  hub_vnet_name                  = module.hub_vnet.vnet_name
  hub_resource_group_name        = azurerm_resource_group.hub.name
  tags                           = local.tags
}

module "key_vault" {
  source                     = "../../modules/key-vault"
  key_vault_name             = "kv-${var.environment}-${var.location_short}-${var.unique_suffix}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.hub.name
  log_analytics_workspace_id = module.log_analytics.workspace_id
  tags                       = local.tags
}

module "aks" {
  source                     = "../../modules/aks"
  cluster_name               = "aks-${var.environment}-${var.location_short}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.spoke.name
  dns_prefix                 = "aks-${var.environment}"
  kubernetes_version         = var.kubernetes_version
  sku_tier                   = var.aks_sku_tier
  subnet_id                  = module.spoke_vnet.workload_subnet_id
  system_node_vm_size        = var.aks_system_node_vm_size
  system_node_min_count      = var.aks_system_node_min_count
  system_node_max_count      = var.aks_system_node_max_count
  enable_user_node_pool      = var.aks_enable_user_node_pool
  user_node_vm_size          = var.aks_user_node_vm_size
  user_node_min_count        = var.aks_user_node_min_count
  user_node_max_count        = var.aks_user_node_max_count
  log_analytics_workspace_id = module.log_analytics.workspace_id
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  tags                       = local.tags
}

module "azure_policy" {
  source          = "../../modules/azure-policy"
  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  deny_public_ip  = true
  allowed_vm_skus = var.allowed_vm_skus
}

module "budget" {
  source         = "../../modules/budget"
  budget_name    = "budget-${var.environment}"
  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  monthly_amount = var.monthly_budget
  start_date     = var.budget_start_date
  alert_emails   = var.budget_alert_emails
}
