output "role_names" {
  description = "All created roles by module"

  value = compact(
    [
      var.role_admin_enabled ? local.role_admin : "",
      var.role_readonly_enabled ? local.role_readonly : "",
    ],
  )
}

output "role_readonly_access_arn" {
  description = "ARN of Read Only Access IAM Role"
  value       = join("", aws_iam_role.readonly-access.*.arn)
}

output "role_readonly_access_id" {
  description = "Name of Read Only Access IAM Role"
  value       = join("", aws_iam_role.readonly-access.*.id)
}

output "role_admin_access_arn" {
  description = "ARN of Administrator Access IAM Role"
  value       = join("", aws_iam_role.administrator-access.*.arn)
}

output "role_admin_access_id" {
  description = "Name of Administrator Access IAM Role"
  value       = join("", aws_iam_role.administrator-access.*.id)
}