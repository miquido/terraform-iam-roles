# Administrator access

locals {
  tags = "${merge(var.tags, map("Provisioned-By", "Miquido-IAM-Roles"))}"
}


resource "aws_iam_role" "administrator-access" {
  name = "AdministratorAccess"
  tags = "${local.tags}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.authentication_account_no}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
}

data "aws_iam_policy" "administrator-access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "administrator-access-attach" {
  role       = "${aws_iam_role.administrator-access.name}"
  policy_arn = "${data.aws_iam_policy.administrator-access.arn}"
}

resource "aws_iam_policy" "deny-ct-write" {
  name = "DenyCloudTrailWrite"

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
  role       = "${aws_iam_role.administrator-access.name}"
  policy_arn = "${aws_iam_policy.deny-ct-write.arn}"
}

# Read only access

resource "aws_iam_role" "readonly-access" {
  name = "ReadOnlyAccess"
  tags = "${local.tags}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.authentication_account_no}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
}

data "aws_iam_policy" "readonly-access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "readonly-access-attach" {
  role       = "${aws_iam_role.readonly-access.name}"
  policy_arn = "${data.aws_iam_policy.readonly-access.arn}"
}

# Alexa developer

resource "aws_iam_role" "alexa-developer" {
  name = "AlexaDeveloper"
  tags = "${local.tags}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.authentication_account_no}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
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

resource "aws_iam_role_policy_attachment" "alexa-developer-alexa-full-access-attach" {
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${data.aws_iam_policy.alexa-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-lex-full-access-attach" {
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${data.aws_iam_policy.lex-full-access.arn}"
}

resource "aws_iam_role_policy_attachment" "alexa-developer-lambda-full-access-attach" {
  role       = "${aws_iam_role.alexa-developer.name}"
  policy_arn = "${data.aws_iam_policy.lambda-full-access.arn}"
}
