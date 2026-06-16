provider "aws" {
  region = "us-east-1"
}

module "iam-roles-complete" {
  source = "../.."

  role_readonly_enabled      = true
  roles_max_session_duration = 43200

  admin_principals = [
    { arn = "arn:aws:iam::123456789012:role/ci-admin-role" },
    { sso = "123456789012" },
    { arn = "arn:aws:iam::123456789012:user/admin-user", mfa = true },
  ]

  readonly_principals = [
    { arn = "arn:aws:iam::123456789012:role/ci-readonly-role" },
    { sso = "123456789012" },
  ]
}