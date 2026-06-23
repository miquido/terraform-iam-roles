# terraform-iam-roles <a href="https://miquido.com"><img align="right" src="https://cdn.miquido.dev/miquido-logo.png" width="150" /></a>

Terraform module that creates AWS IAM roles (Administrator Access and ReadOnly Access) with configurable trust policies supporting IAM users/roles and AWS SSO principals.

## Development

```bash
make init   # run once after cloning
make readme # regenerate README.md
make lint   # lint terraform code
```

## Usage

```hcl
module "iam_roles" {
  source = "git@gitlab.miquido.com:miquido/terraform/terraform-iam-roles.git?ref=<version>"

  admin_principals = [
    { arn = "arn:aws:iam::123456789012:root" },
    { sso = "123456789012" },
  ]

  readonly_principals = [
    { arn = "arn:aws:iam::123456789012:user/devops", mfa = true },
  ]

  roles_prefix = "MyPrefix-"
  tags = {
    Environment = "production"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.6 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_iam_role.administrator-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.readonly-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.administrator-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_principals"></a> [admin\_principals](#input\_admin\_principals) | Principals allowed to assume admin roles. arn: IAM user/role/account ARN; sso: account number for SSO wildcard (ArnLike); mfa: require MFA (default false). SSO never requires MFA. | <pre>list(object({<br/>    arn = optional(string, null)<br/>    sso = optional(string, null)<br/>    mfa = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_assume_role_external_id"></a> [assume\_role\_external\_id](#input\_assume\_role\_external\_id) | Specify external ID required to assume enabled roles. Disabled if empty. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-xaccount | `string` | `""` | no |
| <a name="input_readonly_principals"></a> [readonly\_principals](#input\_readonly\_principals) | Principals allowed to assume the ReadOnly role. Same structure as admin\_principals. | <pre>list(object({<br/>    arn = optional(string, null)<br/>    sso = optional(string, null)<br/>    mfa = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_role_admin_enabled"></a> [role\_admin\_enabled](#input\_role\_admin\_enabled) | Whether to enable AdministratorAccess IAM Role | `bool` | `true` | no |
| <a name="input_role_readonly_enabled"></a> [role\_readonly\_enabled](#input\_role\_readonly\_enabled) | Whether to enable ReadOnlyAccess IAM Role | `bool` | `true` | no |
| <a name="input_roles_max_session_duration"></a> [roles\_max\_session\_duration](#input\_roles\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `3600` | no |
| <a name="input_roles_prefix"></a> [roles\_prefix](#input\_roles\_prefix) | Prefix added to created roles | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply on all created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_admin_access_arn"></a> [role\_admin\_access\_arn](#output\_role\_admin\_access\_arn) | ARN of Administrator Access IAM Role |
| <a name="output_role_admin_access_id"></a> [role\_admin\_access\_id](#output\_role\_admin\_access\_id) | Name of Administrator Access IAM Role |
| <a name="output_role_names"></a> [role\_names](#output\_role\_names) | All created roles by module |
| <a name="output_role_readonly_access_arn"></a> [role\_readonly\_access\_arn](#output\_role\_readonly\_access\_arn) | ARN of Read Only Access IAM Role |
| <a name="output_role_readonly_access_id"></a> [role\_readonly\_access\_id](#output\_role\_readonly\_access\_id) | Name of Read Only Access IAM Role |
<!-- END_TF_DOCS -->

## License

[MIT](LICENSE)
