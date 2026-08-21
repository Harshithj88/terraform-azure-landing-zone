variable "vnet_name" {
  description = "Name of the hub virtual network"
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

variable "address_space" {
  description = "Address space for the hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "gateway_subnet_prefix" {
  description = "Address prefix for the Gateway subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "firewall_subnet_prefix" {
  description = "Address prefix for the Azure Firewall subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "bastion_subnet_prefix" {
  description = "Address prefix for the Azure Bastion subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "enable_bastion" {
  description = "Deploy Azure Bastion in the hub"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
