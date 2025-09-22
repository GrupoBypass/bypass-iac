# Security group for public EC2
resource "aws_security_group" "public_ec2" {
  name_prefix = "grafana-sg-"
  vpc_id      = var.vpc_id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
    description = "SSH access"
  }

  # HTTP access (common for web servers)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # Additional custom rules
  dynamic "ingress" {
    for_each = var.extra_security_group_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "grafana-security-group"
  }
}

# Public EC2 instance
resource "aws_instance" "public_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  # Use the first public subnet
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.public_ec2.id]
  associate_public_ip_address = true

  # Root volume configuration
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "grafana"
  }

  # Enable detailed monitoring
  monitoring = true
}

# Elastic IP for static public IP (optional)
# resource "aws_eip" "public_instance" {
#   domain = "vpc"
#   instance = aws_instance.public_instance.id
#   
#   tags = {
#     Name = "${var.name}-eip"
#   }
# }
