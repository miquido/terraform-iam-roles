## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| authentication_account_no | (Required) Number of AWS Organization Account used to manage IAM users | string | - | yes |
| tags | (Optional) Additional tags to apply on all created resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_admin_access_arn | ARN of Administrator Access IAM Role |
| role_admin_access_id | Name of Administrator Access IAM Role |
| role_names | All created roles by module |
| role_readonly_access_arn | ARN of Read Only Access IAM Role |
| role_readonly_access_id | Name of Read Only Access IAM Role |

