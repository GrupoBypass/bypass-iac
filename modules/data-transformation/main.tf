# Create security group if not passed from parent
resource "aws_security_group" "private_instances" {
  count = var.security_group_id == "" ? 1 : 0
  
  name_prefix = "data-transform-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] # Only allow SSH from within VPC
  }

  # Add any other ports your data transformation needs
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] # Example app port
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound
  }

  tags = {
    Name = "data-transformation-sg"
  }
}

# Use provided security group or create one
locals {
  security_group_id = var.security_group_id != "" ? var.security_group_id : aws_security_group.private_instances[0].id
}

# Create private EC2 instances for data transformation
resource "aws_instance" "data_transformer" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  # Distribute across available private subnets
  subnet_id              = var.private_subnet_ids[count.index % length(var.private_subnet_ids)]
  vpc_security_group_ids = [local.security_group_id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  # Private instances don't get public IPs
  associate_public_ip_address = false

  tags = {
    Name = "data-transformer-${count.index + 1}"
  }
}
