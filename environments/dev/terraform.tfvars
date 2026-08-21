environment          = "dev"
location             = "westus2"
location_short       = "wus2"
owner                = "platform-engineering"
unique_suffix        = "x1d"

# Networking
hub_address_space                    = "10.0.0.0/16"
hub_gateway_subnet_prefix            = "10.0.1.0/24"
hub_firewall_subnet_prefix           = "10.0.2.0/24"
hub_bastion_subnet_prefix            = "10.0.3.0/24"
enable_bastion                       = false
spoke_address_space                  = "10.1.0.0/16"
spoke_workload_subnet_prefix         = "10.1.1.0/24"
spoke_private_endpoint_subnet_prefix = "10.1.2.0/24"

# AKS
kubernetes_version        = "1.29"
aks_sku_tier              = "Free"
aks_system_node_vm_size   = "Standard_D2s_v5"
aks_system_node_min_count = 1
aks_system_node_max_count = 3
aks_enable_user_node_pool = false

# Monitoring
log_retention_days = 30

# Budget
monthly_budget      = 500
budget_start_date   = "2025-01-01T00:00:00Z"
budget_alert_emails = ["platform-alerts@example.com"]
