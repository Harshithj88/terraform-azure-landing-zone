variable "workspace_name" {
  description = "Log Analytics workspace name"
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

variable "retention_days" {
  description = "Data retention in days"
  type        = number
  default     = 30
}

variable "daily_quota_gb" {
  description = "Daily ingestion quota in GB (-1 for unlimited)"
  type        = number
  default     = -1
}

variable "enable_container_insights" {
  description = "Enable Container Insights solution"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
