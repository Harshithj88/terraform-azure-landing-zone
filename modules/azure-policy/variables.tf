variable "subscription_id" {
  description = "Azure subscription ID for policy assignments"
  type        = string
}

variable "management_group_id" {
  description = "Management group ID for location policy (empty to skip)"
  type        = string
  default     = ""
}

variable "allowed_locations" {
  description = "List of allowed Azure regions"
  type        = list(string)
  default     = ["westus2", "eastus2", "centralus"]
}

variable "deny_public_ip" {
  description = "Deny creation of public IP addresses"
  type        = bool
  default     = false
}

variable "allowed_vm_skus" {
  description = "List of allowed VM SKUs (empty to skip)"
  type        = list(string)
  default     = []
}
