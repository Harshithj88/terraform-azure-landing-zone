variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "security_rules" {
  description = "List of security rule objects"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string)
    destination_port_ranges    = optional(list(string))
    source_address_prefix      = optional(string)
    source_address_prefixes    = optional(list(string))
    destination_address_prefix = optional(string, "*")
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      contains(["Inbound", "Outbound"], rule.direction) &&
      contains(["Allow", "Deny"], rule.access) &&
      contains(["Tcp", "Udp", "Icmp", "*"], rule.protocol)
    ])
    error_message = "Each rule must have valid direction (Inbound/Outbound), access (Allow/Deny), and protocol (Tcp/Udp/Icmp/*)."
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate this NSG with"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
