# Configure the AWS Provider
terraform {
  required_version = ">= 1.0" # Specify your Terraform version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  # Optional: Backend configuration for storing state remotely
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "bypass-vpc/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-lock-table"
  #   encrypt        = true
  # }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Default region

  # Optional: Assume role for cross-account access
  # assume_role {
  #   role_arn = "arn:aws:iam::ACCOUNT_ID:role/TerraformRole"
  # }

  # Optional: Default tags for all resources
  default_tags {
    tags = {
      Environment   = "dev"
      Terraform     = "true"
      Project       = "bypass-vpc"
      ManagedBy     = "terraform"
    }
  }
}

# Optional: Additional provider configuration for other regions
# provider "aws" {
#   alias  = "us-west-2"
#   region = "us-west-2"
# }
