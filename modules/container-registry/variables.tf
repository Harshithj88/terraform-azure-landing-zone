variable "registry_name" {
  description = "Globally unique registry name (5-50 alphanumeric characters)"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.registry_name))
    error_message = "Registry name must be 5-50 alphanumeric characters."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "Registry SKU"
  type        = string
  default     = "Premium"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard, or Premium."
  }
}

variable "admin_enabled" {
  description = "Enable the admin user (disable in production; prefer RBAC/managed identity)"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Allow public network access"
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundancy (Premium SKU only)"
  type        = bool
  default     = true
}

variable "retention_days" {
  description = "Untagged manifest retention in days (Premium SKU only)"
  type        = number
  default     = 30
}

variable "geo_replications" {
  description = "Geo-replication regions (Premium SKU only)"
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool, true)
  }))
  default = []
}

variable "enable_delete_lock" {
  description = "Enable a CanNotDelete management lock"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
