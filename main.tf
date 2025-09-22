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
