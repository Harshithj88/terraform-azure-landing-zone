variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "sku_tier" {
  description = "AKS SKU tier (Free or Standard)"
  type        = string
  default     = "Standard"
}

variable "subnet_id" {
  description = "Subnet ID for the node pools"
  type        = string
}

variable "system_node_vm_size" {
  description = "VM size for the system node pool"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "system_node_min_count" {
  description = "Minimum nodes in system pool"
  type        = number
  default     = 2
}

variable "system_node_max_count" {
  description = "Maximum nodes in system pool"
  type        = number
  default     = 5
}

variable "enable_user_node_pool" {
  description = "Deploy a separate user node pool"
  type        = bool
  default     = true
}

variable "user_node_vm_size" {
  description = "VM size for the user node pool"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "user_node_min_count" {
  description = "Minimum nodes in user pool"
  type        = number
  default     = 1
}

variable "user_node_max_count" {
  description = "Maximum nodes in user pool"
  type        = number
  default     = 10
}

variable "availability_zones" {
  description = "Availability zones for node pools"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "service_cidr" {
  description = "Kubernetes service CIDR"
  type        = string
  default     = "172.16.0.0/16"
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP"
  type        = string
  default     = "172.16.0.10"
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for monitoring"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "acr_id" {
  description = "Azure Container Registry ID for AcrPull role assignment"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
