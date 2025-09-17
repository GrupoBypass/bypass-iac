output "instance_ids" {
  description = "IDs of the data transformation instances"
  value       = aws_instance.data_transformer[*].id
}

output "instance_private_ips" {
  description = "Private IPs of the data transformation instances"
  value       = aws_instance.data_transformer[*].private_ip
}

output "security_group_id" {
  description = "Security group ID used for the instances"
  value       = local.security_group_id
}
