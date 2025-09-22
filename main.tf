# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# Data Transformation Module 
module "data_transformation" {
  source = "./modules/data-transformation"

  private_subnet_ids = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = module.vpc.vpc_cidr_block
  
  instance_type = var.ec2_instance_type
  key_name      = var.key_name
  ami_id        = var.ami_id
  instance_count = 2
}

module "storage" {
  source = "./modules/storage"

  # Pass all variables from terraform.tfvars
  bucket_count          = var.bucket_count
  bucket_prefix         = var.bucket_prefix
  bucket_names          = var.bucket_names
  use_custom_names      = var.use_custom_names
  bucket_acl            = var.bucket_acl
  enable_versioning     = var.enable_versioning
  enable_website        = var.enable_website
  website_index_document = var.website_index_document
  website_error_document = var.website_error_document
  tags                  = var.tags
}
