resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier
  tags                = var.tags

  default_node_pool {
    name                = "system"
    vm_size             = var.system_node_vm_size
    min_count           = var.system_node_min_count
    max_count           = var.system_node_max_count
    os_disk_size_gb     = 128
    vnet_subnet_id      = var.subnet_id
    zones               = var.availability_zones
    auto_scaling_enabled = true

    node_labels = {
      "nodepool" = "system"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    load_balancer_sku = "standard"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    tenant_id          = var.tenant_id
  }

  auto_scaler_profile {
    balance_similar_node_groups = true
    max_graceful_termination_sec = 600
    scale_down_delay_after_add   = "10m"
    scale_down_unneeded          = "10m"
    max_unready_nodes            = 3
  }

  maintenance_window_auto_upgrade {
    frequency = "Weekly"
    interval  = 1
    day_of_week = "Sunday"
    start_time  = "02:00"
    utc_offset  = "-06:00"
    duration    = 4
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count                 = var.enable_user_node_pool ? 1 : 0
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.user_node_vm_size
  min_count             = var.user_node_min_count
  max_count             = var.user_node_max_count
  os_disk_size_gb       = 128
  vnet_subnet_id        = var.subnet_id
  zones                 = var.availability_zones
  auto_scaling_enabled  = true
  tags                  = var.tags

  node_labels = {
    "nodepool" = "user"
  }

  node_taints = ["workload=true:NoSchedule"]

  lifecycle {
    ignore_changes = [node_count]
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  count                = var.acr_id != "" ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
