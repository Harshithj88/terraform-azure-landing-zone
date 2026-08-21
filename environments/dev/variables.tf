variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westus2"
}

variable "location_short" {
  description = "Short Azure region code for naming"
  type        = string
  default     = "wus2"
}

variable "owner" {
  description = "Owner tag value"
  type        = string
}

variable "unique_suffix" {
  description = "Unique suffix for globally unique resource names"
  type        = string
}

variable "hub_address_space" {
  description = "Hub VNet address space"
  type        = string
  default     = "10.0.0.0/16"
}

variable "hub_gateway_subnet_prefix" {
  description = "Hub gateway subnet prefix"
  type        = string
  default     = "10.0.1.0/24"
}

variable "hub_firewall_subnet_prefix" {
  description = "Hub firewall subnet prefix"
  type        = string
  default     = "10.0.2.0/24"
}

variable "hub_bastion_subnet_prefix" {
  description = "Hub bastion subnet prefix"
  type        = string
  default     = "10.0.3.0/24"
}

variable "enable_bastion" {
  description = "Deploy Azure Bastion in the hub"
  type        = bool
  default     = false
}

variable "spoke_address_space" {
  description = "Spoke VNet address space"
  type        = string
  default     = "10.1.0.0/16"
}

variable "spoke_workload_subnet_prefix" {
  description = "Spoke workload subnet prefix"
  type        = string
  default     = "10.1.1.0/24"
}

variable "spoke_private_endpoint_subnet_prefix" {
  description = "Spoke private endpoint subnet prefix"
  type        = string
  default     = "10.1.2.0/24"
}

variable "log_retention_days" {
  description = "Log Analytics retention in days"
  type        = number
  default     = 30
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "aks_sku_tier" {
  description = "AKS SKU tier"
  type        = string
  default     = "Free"
}

variable "aks_system_node_vm_size" {
  description = "VM size for AKS system nodes"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "aks_system_node_min_count" {
  description = "Min system node count"
  type        = number
  default     = 1
}

variable "aks_system_node_max_count" {
  description = "Max system node count"
  type        = number
  default     = 3
}

variable "aks_enable_user_node_pool" {
  description = "Deploy a user node pool"
  type        = bool
  default     = false
}

variable "monthly_budget" {
  description = "Monthly budget in USD"
  type        = number
  default     = 500
}

variable "budget_start_date" {
  description = "Budget start date (YYYY-MM-01)"
  type        = string
}

variable "budget_alert_emails" {
  description = "Email addresses for budget alerts"
  type        = list(string)
}
