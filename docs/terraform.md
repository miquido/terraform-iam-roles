## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| policies_prefix | Prefix added to created roles | string | `` | no |
| principals | List of AWS Prinicpals to allow assuming created IAM roles (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) | list(string) | - | yes |
| role_set | Specify which role set is enabled. Check role_enabled map for informations which roles are enabled in specific set. | string | `all` | no |
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

