variable "authentication_account_no" {
  type        = "string"
  description = "(Required) Number of AWS Organization Account used to manage IAM users"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "(Optional) Additional tags to apply on all created resources"
}
