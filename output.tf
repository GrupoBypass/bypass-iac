# Data transformation module outputs
output "data_transformer_ips" {
  value = module.data_transformation.instance_private_ips
}

output "data_transformer_ids" {
  value = module.data_transformation.instance_ids
}
