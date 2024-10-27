# Subnet group for the RDS instance in the default VPC
resource "aws_db_subnet_group" "default" {
  name       = "default-subnet-group"
  subnet_ids = data.aws_subnet_ids.default.ids

  tags = {
    Name = "default-subnet-group"
  }
}

# Get the default VPC's subnets
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group to allow inbound access to the RDS instance
resource "aws_security_group" "rds_security_group" {
  name        = "rds_security_group"
  description = "Security group for RDS MySQL access"

  # Allow MySQL port access from anywhere (use a more restrictive source if needed)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows all IPs; restrict this in production
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}
