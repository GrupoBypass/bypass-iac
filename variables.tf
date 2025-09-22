# VPC Configuration
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "bypass-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "environment" {
  description = "Environment tag value"
  type        = string
  default     = "dev"
}

# EC2 Configuration
variable "ec2_instance_type" {
  description = "EC2 instance type for all instances"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "my-keypair"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
}

# Data Transformation Configuration
variable "data_transformation_instance_count" {
  description = "Number of private instances for data transformation"
  type        = number
  default     = 2
}

#GRAFANA
variable "allowed_ssh_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into public instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# S3 Module Variables
variable "bucket_count" {
  description = "Number of public buckets to create"
  type        = number
  default     = 1
}

variable "bucket_prefix" {
  description = "Prefix for bucket names"
  type        = string
  default     = "public-bucket"
}

variable "bucket_names" {
  description = "Custom bucket names"
  type        = list(string)
  default     = []
}

variable "use_custom_names" {
  description = "Whether to use custom bucket names"
  type        = bool
  default     = false
}

variable "bucket_acl" {
  description = "ACL for the buckets"
  type        = string
  default     = "public-read"
}

variable "enable_versioning" {
  description = "Enable versioning for the buckets"
  type        = bool
  default     = false
}

variable "enable_website" {
  description = "Enable static website hosting"
  type        = bool
  default     = false
}

variable "website_index_document" {
  description = "Index document for website configuration"
  type        = string
  default     = "index.html"
}

variable "website_error_document" {
  description = "Error document for website configuration"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Additional tags for the buckets"
  type        = map(string)
  default     = {}
}

# AWS Provider Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
