<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![Miquido][logo]](https://www.miquido.com/)

# miquido-iam-roles
Roles provisioned by module:

- `AdministratorAccess`

    administrator access policy to assume from authentication account

- `ReadOnlyAccess`

    read only access policy to assume from authentication account

- `AlexaDeveloper`

    full access policy to: `Lambda`, `Lex` and `Alexa` to assume from authentication account

- `SuperAdministratorAccess`

    same as `AdministratorAccess` with ability to manage CloudTrail resources
---
**Terraform Module**
## Usage

```hcl
module "iam-roles" {
  source = "git::ssh://git@bitbucket.org/miquido/terraform-iam-roles.git?ref=master"
  principals = ["xxxxx"]
}
```

### Enable only specific roles

Not always all roles are desirable. To enable only one set of roles, use module like bellow.

```hcl
module "iam-roles" {
  source = "git::ssh://git@bitbucket.org/miquido/terraform-iam-roles.git?ref=master"

  principals            = ["xxxxx"]
  role_admin_enabled    = true
  role_readonly_enabled = true
}
```

### Multiple accounts

#### To allow assuming roles from different AWS accounts you can provide serveal prinicipals

module "iam-roles" {
  source = "git::ssh://git@bitbucket.org/miquido/terraform-iam-roles.git?ref=master"

  principals = ["arn:aws:iam::xxxxone:root", "arn:aws:iam::xxxxtwo:root"]
}

#### To use multiple IAM roles modules inside one AWS account for different reasons, you can use unique `roles_prefix` and `policies_prefix` to avoid IAM resources' names collisions.

```hcl
module "iam-roles-account-one" {
  source = "git::ssh://git@bitbucket.org/miquido/terraform-iam-roles.git?ref=master"

  principals            = ["xxxxxone"]
  policies_prefix       = "AccountOne"
  roles_prefix          = "AccountOne"
  role_admin_enabled    = false
  role_readonly_enabled = true

  tags = {
    "Heritage" = "Account One"
  }
}

module "iam-roles-account-two" {
  source = "git::ssh://git@bitbucket.org/miquido/terraform-iam-roles.git?ref=master"

  principals            = ["xxxxxtwo"]
  policies_prefix       = "AccountTwo"
  roles_prefix          = "AccountTwo"
  role_admin_enabled    = true
  role_readonly_enabled = true

  tags = {
    "Heritage" = "Account Two"
  }
}
```
<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint Terraform code

```
<!-- markdownlint-restore -->
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


## Developing

1. Make changes in terraform files

2. Regenerate documentation

    ```bash
    bash <(git archive --remote=git@gitlab.com:miquido/terraform/terraform-readme-update.git master update.sh | tar -xO)
    ```

3. Run lint

    ```
    make lint
    ```

## Copyright

Copyright © 2017-2020 [Miquido](https://miquido.com)



### Contributors

|  [![Konrad Obal][k911_avatar]][k911_homepage]<br/>[Konrad Obal][k911_homepage] |
|---|

  [k911_homepage]: https://github.com/k911
  [k911_avatar]: https://github.com/k911.png?size=150



  [logo]: https://www.miquido.com/img/logos/logo__miquido.svg
  [website]: https://www.miquido.com/
  [gitlab]: https://gitlab.com/miquido
  [github]: https://github.com/miquido
  [bitbucket]: https://bitbucket.org/miquido

