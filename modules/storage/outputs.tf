output "bucket_ids" {
  description = "List of bucket IDs"
  value       = aws_s3_bucket.this[*].id
}

output "bucket_arns" {
  description = "List of bucket ARNs"
  value       = aws_s3_bucket.this[*].arn
}

output "bucket_domain_names" {
  description = "List of bucket domain names"
  value       = aws_s3_bucket.this[*].bucket_domain_name
}

output "bucket_regional_domain_names" {
  description = "List of bucket regional domain names"
  value       = aws_s3_bucket.this[*].bucket_regional_domain_name
}
