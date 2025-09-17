variable "private_subnet_ids" {
  description = "List of private subnet IDs from VPC"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for private instances"
  type        = string
  default     = "" # Optional: can create own SG in module
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_count" {
  description = "Number of private instances to create"
  type        = number
  default     = 2
}
