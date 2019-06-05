variable "authentication_account_no" {
  type        = "string"
  description = "Number of AWS Organization Account used to manage IAM users"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags to apply on all created resources"
}

variable "roles_prefix" {
  type        = "string"
  default     = ""
  description = "Prefix added to created roles"
}

variable "policies_prefix" {
  type        = "string"
  default     = ""
  description = "Prefix added to created roles"
}
