variable "principals" {
  type        = "list"
  description = "List of AWS Prinicpals to allow assuming created IAM roles (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html)"
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
