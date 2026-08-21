environment          = "prod"
location             = "westus2"
location_short       = "wus2"
owner                = "platform-engineering"
unique_suffix        = "p1a"

# Networking
hub_address_space                    = "10.100.0.0/16"
hub_gateway_subnet_prefix            = "10.100.1.0/24"
hub_firewall_subnet_prefix           = "10.100.2.0/24"
hub_bastion_subnet_prefix            = "10.100.3.0/24"
enable_bastion                       = true
spoke_address_space                  = "10.101.0.0/16"
spoke_workload_subnet_prefix         = "10.101.1.0/24"
spoke_private_endpoint_subnet_prefix = "10.101.2.0/24"

# AKS
kubernetes_version        = "1.29"
aks_sku_tier              = "Standard"
aks_system_node_vm_size   = "Standard_D4s_v5"
aks_system_node_min_count = 2
aks_system_node_max_count = 5
aks_enable_user_node_pool = true
aks_user_node_vm_size     = "Standard_D4s_v5"
aks_user_node_min_count   = 2
aks_user_node_max_count   = 10
allowed_vm_skus           = ["Standard_D2s_v5", "Standard_D4s_v5", "Standard_D8s_v5"]

# Monitoring
log_retention_days = 90

# Budget
monthly_budget      = 3000
budget_start_date   = "2025-01-01T00:00:00Z"
budget_alert_emails = ["platform-alerts@example.com", "engineering-leads@example.com"]
