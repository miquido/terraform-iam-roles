<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 2.29.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.29.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_external\_id | Specify external ID required to assume enabled roles. Disabled if empty. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-xaccount | `string` | `""` | no |
| assume\_role\_mfa\_enabled | Whether to require MFA to assume enabled roles. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-mfa | `bool` | `true` | no |
| policies\_prefix | Prefix added to created roles | `string` | `""` | no |
| principals | List of AWS Prinicpals to allow assuming created IAM roles (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) | `list(string)` | n/a | yes |
| role\_admin\_enabled | Whether to enable AdministratorAccess IAM Role | `bool` | `true` | no |
| role\_alexa\_enabled | Whether to enable AlexaDeveloper IAM Role | `bool` | `false` | no |
| role\_analyst\_enabled | Whether to enable Analyst IAM Role (ReadOnly + AmazonAthenaFullAccess) | `bool` | `false` | no |
| role\_readonly\_enabled | Whether to enable ReadOnlyAccess IAM Role | `bool` | `true` | no |
| role\_superadmin\_enabled | Whether to enable SuperAdministratorAccess IAM Role (Administrator with ability to manage CloudTrail) | `bool` | `false` | no |
| roles\_max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `3600` | no |
| roles\_prefix | Prefix added to created roles | `string` | `""` | no |
| tags | Additional tags to apply on all created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_admin\_access\_arn | ARN of Administrator Access IAM Role |
| role\_admin\_access\_id | Name of Administrator Access IAM Role |
| role\_alexa\_developer\_arn | ARN of Administrator Access IAM Role |
| role\_alexa\_developer\_id | Name of Administrator Access IAM Role |
| role\_analyst\_developer\_arn | ARN of Analyst Access IAM Role |
| role\_analyst\_developer\_id | Name of Analyst Access IAM Role |
| role\_names | All created roles by module |
| role\_readonly\_access\_arn | ARN of Read Only Access IAM Role |
| role\_readonly\_access\_id | Name of Read Only Access IAM Role |
| role\_superadmin\_access\_arn | ARN of Administrator Access IAM Role (ability to manage CloudTrail) |
| role\_superadmin\_access\_id | Name of Administrator Access IAM Role (ability to manage CloudTrail) |

<!-- markdownlint-restore -->
