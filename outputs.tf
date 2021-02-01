output "launch_configuration_id" {
  description = "ID of the launch configruation that is created."
  value       = element(concat(aws_launch_configuration.this.*.id, list("")), 0)
}

output "launch_configuration_name" {
  description = "Name of the launch configruation that is created."
  value       = element(concat(aws_launch_configuration.this.*.name, list("")), 0)
}

output "autoscaling_group_id" {
  description = "ID of the autoscaling group that is created."
  value       = element(concat(aws_autoscaling_group.this.*.id, list("")), 0)
}

output "autoscaling_group_arn" {
  description = "ARN of the autoscaling group that is created."
  value       = element(concat(aws_autoscaling_group.this.*.arn, list("")), 0)
}

output "iam_role_name" {
  description = "Name of the IAM role that is created."
  value       = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

output "iam_role_id" {
  description = "ID of the IAM role that is created."
  value       = element(concat(aws_iam_role.this.*.id, list("")), 0)
}

output "iam_role_arn" {
  description = "ARN of the IAM role that is created."
  value       = element(concat(aws_iam_role.this.*.arn, list("")), 0)
}

output "iam_role_unique_id" {
  description = "Uniauq ID of the IAM role that is created."
  value       = element(concat(aws_iam_role.this.*.unique_id, list("")), 0)
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile that is created."
  value       = element(concat(aws_iam_instance_profile.this.*.name, list("")), 0)
}

output "iam_instance_profile_id" {
  description = "ID of the IAM instance profile that is created."
  value       = element(concat(aws_iam_instance_profile.this.*.id, list("")), 0)
}

output "iam_instance_profile_arn" {
  description = "ARN of the IAM instance profile that is created."
  value       = element(concat(aws_iam_instance_profile.this.*.arn, list("")), 0)
}

output "iam_instance_profile_unique_id" {
  description = "Uniauq ID of the IAM instance profile that is created."
  value       = element(concat(aws_iam_instance_profile.this.*.unique_id, list("")), 0)
}

output "aws_auth_data" {
  description = "List of maps representing the needed config to add to the aws-auth configmap on EKS."
  value       = var.enabled ? local.aws_auth_data : []
}
