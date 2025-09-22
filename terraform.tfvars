# VPC Configuration
vpc_name = "bypass-production-vpc"
vpc_cidr = "10.0.0.0/16"
azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]

private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

environment = "prod"

# EC2 Configuration
ec2_instance_type = "t3.small"
key_name          = "production-keypair"
ami_id            = "ami-0b0ea68c435eb488d" # Update with your actual AMI

# Data Transformation
data_transformation_instance_count = 2
