variable "zone_name" {
  description = "Private DNS zone name (e.g., privatelink.blob.core.windows.net)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_links" {
  description = "List of VNet links to associate with the DNS zone"
  type = list(object({
    name                 = string
    vnet_id              = string
    registration_enabled = optional(bool, false)
  }))
  default = []
}

variable "a_records" {
  description = "Optional A records to create in the zone"
  type = list(object({
    name    = string
    records = list(string)
    ttl     = optional(number, 300)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
