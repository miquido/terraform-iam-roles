## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume_role_external_id | Specify external ID required to assume enabled roles. Disabled if empty. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-xaccount | string | `` | no |
| assume_role_mfa_enabled | Whether to require MFA to assume enabled roles. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-mfa | bool | `true` | no |
| policies_prefix | Prefix added to created roles | string | `` | no |
| principals | List of AWS Prinicpals to allow assuming created IAM roles (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) | list(string) | - | yes |
| role_admin_enabled | Whether to enable AdministratorAccess IAM Role | bool | `true` | no |
| role_alexa_enabled | Whether to enable AlexaDeveloper IAM Role | bool | `false` | no |
| role_readonly_enabled | Whether to enable ReadOnlyAccess IAM Role | bool | `true` | no |
| role_superadmin_enabled | Whether to enable SuperAdministratorAccess IAM Role (Administrator with ability to manage CloudTrail) | bool | `false` | no |
| roles_max_session_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | number | `3600` | no |
| roles_prefix | Prefix added to created roles | string | `` | no |
| tags | Additional tags to apply on all created resources | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_admin_access_arn | ARN of Administrator Access IAM Role |
| role_admin_access_id | Name of Administrator Access IAM Role |
| role_alexa_developer_arn | ARN of Administrator Access IAM Role |
| role_alexa_developer_id | Name of Administrator Access IAM Role |
| role_names | All created roles by module |
| role_readonly_access_arn | ARN of Read Only Access IAM Role |
| role_readonly_access_id | Name of Read Only Access IAM Role |
| role_superadmin_access_arn | ARN of Administrator Access IAM Role (ability to manage CloudTrail) |
| role_superadmin_access_id | Name of Administrator Access IAM Role (ability to manage CloudTrail) |

