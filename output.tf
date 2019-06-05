output "role_names" {
  description = "All created roles by module"

  value = [
    "${local.role_admin}",
    "${local.role_readonly}",
    "${local.role_alexa}",
  ]
}

output "role_readonly_access_arn" {
  description = "ARN of Read Only Access IAM Role"
  value       = "${join("", aws_iam_role.readonly-access.*.arn)}"
}

output "role_readonly_access_id" {
  description = "Name of Read Only Access IAM Role"
  value       = "${join("", aws_iam_role.readonly-access.*.id)}"
}

output "role_admin_access_arn" {
  description = "ARN of Administrator Access IAM Role"
  value       = "${join("", aws_iam_role.administrator-access.*.arn)}"
}

output "role_admin_access_id" {
  description = "Name of Administrator Access IAM Role"
  value       = "${join("", aws_iam_role.administrator-access.*.id)}"
}

output "role_alexa_developer_arn" {
  description = "ARN of Administrator Access IAM Role"
  value       = "${join("", aws_iam_role.alexa-developer.*.arn)}"
}

output "role_alexa_developer_id" {
  description = "Name of Administrator Access IAM Role"
  value       = "${join("", aws_iam_role.alexa-developer.*.id)}"
}
