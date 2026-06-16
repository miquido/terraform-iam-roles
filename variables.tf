variable "admin_principals" {
  type = list(object({
    arn = optional(string, null)
    sso = optional(string, null)
    mfa = optional(bool, false)
  }))
  default     = []
  description = "Principals allowed to assume admin roles. arn: IAM user/role/account ARN; sso: account number for SSO wildcard (ArnLike); mfa: require MFA (default false). SSO never requires MFA."

  validation {
    condition = alltrue([
      for p in var.admin_principals : (p.arn != null) != (p.sso != null)
    ])
    error_message = "Each admin principal must have exactly one of 'arn' or 'sso' set — not both and not neither."
  }

  validation {
    condition = alltrue([
      for p in var.admin_principals : try(startswith(p.arn, "arn:"), true)
    ])
    error_message = "Each admin principal 'arn' must be a valid ARN starting with 'arn:'."
  }

  validation {
    condition = alltrue([
      for p in var.admin_principals : p.sso == null || can(regex("^[0-9]{12}$", p.sso))
    ])
    error_message = "Each admin principal 'sso' must be a 12-digit AWS account ID."
  }

  validation {
    condition = alltrue([
      for p in var.admin_principals : p.sso == null || !p.mfa
    ])
    error_message = "SSO admin principals cannot have mfa = true — SSO does not support MFA enforcement via trust policy."
  }
}

variable "readonly_principals" {
  type = list(object({
    arn = optional(string, null)
    sso = optional(string, null)
    mfa = optional(bool, false)
  }))
  default     = []
  description = "Principals allowed to assume the ReadOnly role. Same structure as admin_principals."

  validation {
    condition = alltrue([
      for p in var.readonly_principals : (p.arn != null) != (p.sso != null)
    ])
    error_message = "Each readonly principal must have exactly one of 'arn' or 'sso' set — not both and not neither."
  }

  validation {
    condition = alltrue([
      for p in var.readonly_principals : try(startswith(p.arn, "arn:"), true)
    ])
    error_message = "Each readonly principal 'arn' must be a valid ARN starting with 'arn:'."
  }

  validation {
    condition = alltrue([
      for p in var.readonly_principals : p.sso == null || can(regex("^[0-9]{12}$", p.sso))
    ])
    error_message = "Each readonly principal 'sso' must be a 12-digit AWS account ID."
  }

  validation {
    condition = alltrue([
      for p in var.readonly_principals : p.sso == null || !p.mfa
    ])
    error_message = "SSO readonly principals cannot have mfa = true — SSO does not support MFA enforcement via trust policy."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply on all created resources"
}

variable "roles_prefix" {
  type        = string
  default     = ""
  description = "Prefix added to created roles"
}

variable "roles_max_session_duration" {
  type        = number
  default     = 3600
  description = " The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
}

variable "assume_role_external_id" {
  type        = string
  default     = ""
  description = "Specify external ID required to assume enabled roles. Disabled if empty. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-xaccount"
}

variable "role_admin_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable AdministratorAccess IAM Role"
}

variable "role_readonly_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable ReadOnlyAccess IAM Role"
}


