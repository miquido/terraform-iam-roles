# Administrator access

locals {
  tags                               = "${merge(var.tags, map("Provisioned-By", "Miquido-IAM-Roles"))}"
  role_admin                         = "${var.roles_prefix}AdministratorAccess"
  role_readonly                      = "${var.roles_prefix}ReadOnlyAccess"
  role_alexa                         = "${var.roles_prefix}AlexaDeveloper"
  policy_deny_ct_write               = "${var.policies_prefix}DenyCloudTrailWrite"
  policy_cloud_formation_full_access = "${var.policies_prefix}CloudFormationFullAccess"
  policy_iam_power_access            = "${var.policies_prefix}IAMRolePowerAccess"
  policy_serveless_repo_full_access  = "${var.policies_prefix}ServerLessRepoFullAccess"

  role_enabled = {
    all = {
      alexa = "true"
    }

    standard = {}

    readonly = {
      admin = "false"
      read  = "true"
    }

    alexa = {
      alexa = "true"
    }
  }

  # Standard - default enabled
  role_admin_enabled    = "${lookup(local.role_enabled[var.role_set], "admin", "true")}"
  role_readonly_enabled = "${lookup(local.role_enabled[var.role_set], "readonly", "true")}"

  # Non standard - default disabled
  role_alexa_enabled = "${lookup(local.role_enabled[var.role_set], "alexa", "false")}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"

  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "AWS"
      identifiers = "${var.principals}"
    }

    condition = {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "administrator-access" {
  count              = "${local.role_admin_enabled == "true" ? 1 : 0}"
  name               = "${local.role_admin}"
  tags               = "${local.tags}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy" "administrator-access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "administrator-access-attach" {
  count      = "${local.role_admin_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.administrator-access.name}"
  policy_arn = "${data.aws_iam_policy.administrator-access.arn}"
}

resource "aws_iam_policy" "deny-ct-write" {
  count = "${local.role_admin_enabled == "true" ? 1 : 0}"
  name  = "${local.policy_deny_ct_write}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Deny",
      "Action": [
        "cloudtrail:PutEventSelectors",
        "cloudtrail:StopLogging",
        "cloudtrail:StartLogging",
        "cloudtrail:AddTags",
        "cloudtrail:DeleteTrail",
        "cloudtrail:UpdateTrail",
        "cloudtrail:CreateTrail",
        "cloudtrail:RemoveTags"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "deny-ct-write-attach" {
  count      = "${local.role_admin_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.administrator-access.name}"
  policy_arn = "${aws_iam_policy.deny-ct-write.arn}"
}

# Read only access

resource "aws_iam_role" "readonly-access" {
  count              = "${local.role_readonly_enabled == "true" ? 1 : 0}"
  name               = "${local.role_readonly}"
  tags               = "${local.tags}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy" "readonly-access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "readonly-access-attach" {
  count      = "${local.role_readonly_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.readonly-access.name}"
  policy_arn = "${data.aws_iam_policy.readonly-access.arn}"
}

# Alexa developer

resource "aws_iam_role" "alexa-developer" {
  count              = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  name               = "${local.role_alexa}"
  tags               = "${local.tags}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy" "lex-full-access" {
  arn = "arn:aws:iam::aws:policy/AmazonLexFullAccess"
}

data "aws_iam_policy" "alexa-full-access" {
  arn = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
}

data "aws_iam_policy" "lambda-full-access" {
  arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}

resource "aws_iam_policy" "cloudformation-full-access" {
  count = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  name  = "${local.policy_cloud_formation_full_access}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudformation:Describe*",
        "cloudformation:EstimateTemplateCost",
        "cloudformation:Get*",
        "cloudformation:List*",
        "cloudformation:ValidateTemplate",
        "cloudformation:DetectStackDrift",
        "cloudformation:DetectStackResourceDrift",
        "cloudformation:CreateChangeSet",
        "cloudformation:ExecuteChangeSet",
        "cloudformation:DeleteStack"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam-role-power-access" {
  count = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  name  = "${local.policy_iam_power_access}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:TagRole",
        "iam:UntagRole",
        "iam:UpdateRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "serverlessrepo-full-access" {
  count = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  name  = "${local.policy_serveless_repo_full_access}"
  path  = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "serverlessrepo:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "alexa-developer-alexa-full-access-attach" {
  count      = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${data.aws_iam_policy.alexa-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-lex-full-access-attach" {
  count      = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${data.aws_iam_policy.lex-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-lambda-full-access-attach" {
  count      = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${data.aws_iam_policy.lambda-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-serverlessrepo-full-access-attach" {
  count      = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${aws_iam_policy.serverlessrepo-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-cloudformation-full-access-attach" {
  count      = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${aws_iam_policy.cloudformation-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-iam-role-power-access-attach" {
  count      = "${local.role_alexa_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${aws_iam_policy.iam-role-power-access.arn}"
}
