# Administrator access

locals {
  tags = merge(
    var.tags,
    {
      "Provisioned-By" = "Miquido-IAM-Roles"
    },
  )

  admin_arns_no_mfa  = [for p in var.admin_principals : p.arn if p.arn != null && !p.mfa]
  admin_arns_mfa     = [for p in var.admin_principals : p.arn if p.arn != null && p.mfa]
  admin_sso_accounts = [for p in var.admin_principals : p.sso if p.sso != null]
  admin_sso_arns     = [for account in local.admin_sso_accounts : "arn:aws:iam::${account}:role/aws-reserved/sso.amazonaws.com/*/AWSReservedSSO_*"]

  readonly_arns_no_mfa  = [for p in var.readonly_principals : p.arn if p.arn != null && !p.mfa]
  readonly_arns_mfa     = [for p in var.readonly_principals : p.arn if p.arn != null && p.mfa]
  readonly_sso_accounts = [for p in var.readonly_principals : p.sso if p.sso != null]
  readonly_sso_arns     = [for account in local.readonly_sso_accounts : "arn:aws:iam::${account}:role/aws-reserved/sso.amazonaws.com/*/AWSReservedSSO_*"]

  role_admin     = "${var.roles_prefix}AdministratorAccess"
  role_readonly  = "${var.roles_prefix}ReadOnlyAccess"
}

data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"

  dynamic "statement" {
    for_each = length(local.admin_arns_no_mfa) == 0 ? [] : [1]
    content {
      sid     = "AllowAssumeRole"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = local.admin_arns_no_mfa
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }

      dynamic "condition" {
        for_each = var.assume_role_external_id == "" ? [] : [var.assume_role_external_id]
        content {
          test     = "StringEquals"
          variable = "sts:ExternalId"
          values   = [condition.value]
        }
      }
    }
  }

  dynamic "statement" {
    for_each = length(local.admin_arns_mfa) == 0 ? [] : [1]
    content {
      sid     = "AllowAssumeRoleWithMFA"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = local.admin_arns_mfa
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }

      condition {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }

      dynamic "condition" {
        for_each = var.assume_role_external_id == "" ? [] : [var.assume_role_external_id]
        content {
          test     = "StringEquals"
          variable = "sts:ExternalId"
          values   = [condition.value]
        }
      }
    }
  }

  dynamic "statement" {
    for_each = length(local.admin_sso_accounts) == 0 ? [] : [1]
    content {
      sid     = "AllowAssumeRoleSSO"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = [for account in local.admin_sso_accounts : "arn:aws:iam::${account}:root"]
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = local.admin_sso_arns
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_policy-readonly" {
  version = "2012-10-17"

  dynamic "statement" {
    for_each = length(local.readonly_arns_no_mfa) == 0 ? [] : [1]
    content {
      sid     = "AllowAssumeRole"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = local.readonly_arns_no_mfa
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }

      dynamic "condition" {
        for_each = var.assume_role_external_id == "" ? [] : [var.assume_role_external_id]
        content {
          test     = "StringEquals"
          variable = "sts:ExternalId"
          values   = [condition.value]
        }
      }
    }
  }

  dynamic "statement" {
    for_each = length(local.readonly_arns_mfa) == 0 ? [] : [1]
    content {
      sid     = "AllowAssumeRoleWithMFA"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = local.readonly_arns_mfa
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }

      condition {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }

      dynamic "condition" {
        for_each = var.assume_role_external_id == "" ? [] : [var.assume_role_external_id]
        content {
          test     = "StringEquals"
          variable = "sts:ExternalId"
          values   = [condition.value]
        }
      }
    }
  }

  dynamic "statement" {
    for_each = length(local.readonly_sso_accounts) == 0 ? [] : [1]
    content {
      sid     = "AllowAssumeRoleSSO"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = [for account in local.readonly_sso_accounts : "arn:aws:iam::${account}:root"]
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = local.readonly_sso_arns
      }
    }
  }
}

resource "aws_iam_role" "administrator-access" {
  count                = var.role_admin_enabled ? 1 : 0
  name                 = local.role_admin
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

data "aws_iam_policy" "administrator-access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "administrator-access-attach" {
  count      = var.role_admin_enabled ? 1 : 0
  role       = aws_iam_role.administrator-access[0].name
  policy_arn = data.aws_iam_policy.administrator-access.arn
}

# Read only access

resource "aws_iam_role" "readonly-access" {
  count                = var.role_readonly_enabled ? 1 : 0
  name                 = local.role_readonly
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy-readonly.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

data "aws_iam_policy" "readonly-access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "readonly-access-attach" {
  count      = var.role_readonly_enabled ? 1 : 0
  role       = aws_iam_role.readonly-access[0].name
  policy_arn = data.aws_iam_policy.readonly-access.arn
}

