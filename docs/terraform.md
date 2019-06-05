## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| authentication_account_no | Number of AWS Organization Account used to manage IAM users | string | - | yes |
| policies_prefix | Prefix added to created roles | string | `` | no |
| role_set | Specify which role set is enabled. Check role_enabled map for informations which roles are enabled in specific set. | string | `all` | no |
| roles_prefix | Prefix added to created roles | string | `` | no |
| tags | Additional tags to apply on all created resources | map | `<map>` | no |

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

