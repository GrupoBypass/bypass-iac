output "instance_id" {
  description = "ID of the public EC2 instance"
  value       = aws_instance.public_instance.id
}

output "public_ip" {
  description = "Public IP of the instance"
  value       = aws_eip.public_instance.public_ip
}

output "private_ip" {
  description = "Private IP of the instance"
  value       = aws_instance.public_instance.private_ip
}

output "security_group_id" {
  description = "Security group ID of the public instance"
  value       = aws_security_group.public_ec2.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.public_instance.arn
}
