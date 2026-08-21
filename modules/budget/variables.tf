variable "budget_name" {
  description = "Name of the budget"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "monthly_amount" {
  description = "Monthly budget amount in USD"
  type        = number
}

variable "start_date" {
  description = "Budget start date (YYYY-MM-01 format)"
  type        = string
}

variable "alert_emails" {
  description = "Email addresses for budget alerts"
  type        = list(string)
}
