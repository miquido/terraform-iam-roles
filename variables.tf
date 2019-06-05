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

variable "role_set" {
  type        = "string"
  default     = "all"
  description = "Specify which role set is enabled. Check role_enabled map for informations which roles are enabled in specific set."
}
