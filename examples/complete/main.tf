provider "aws" {
  region = "us-east-1"
}

module "iam-roles" {
  source = "../.."
  principals = [
    {
      account_no     = "123456789012"
      sso            = true
      root           = false
      admin_roles    = []
      readonly_roles = []
    }
  ]
}
