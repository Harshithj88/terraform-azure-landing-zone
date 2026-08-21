variable "vnet_name" {
  description = "Name of the spoke virtual network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the spoke VNet"
  type        = string
}

variable "address_space" {
  description = "Address space for the spoke VNet"
  type        = list(string)
}

variable "workload_subnet_prefix" {
  description = "Address prefix for the workload subnet"
  type        = string
}

variable "private_endpoint_subnet_prefix" {
  description = "Address prefix for the private endpoints subnet"
  type        = string
}

variable "hub_vnet_id" {
  description = "Resource ID of the hub VNet for peering"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub VNet"
  type        = string
}

variable "hub_resource_group_name" {
  description = "Resource group of the hub VNet"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
