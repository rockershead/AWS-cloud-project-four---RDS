

resource "aws_db_instance" "mydb" {
  identifier             = "my-database"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = 3306
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]

  # Use the default VPC
  db_subnet_group_name = aws_db_subnet_group.default.name

  # Enable backup and retention policy
  backup_retention_period = 7
  skip_final_snapshot     = true


}

output "rds_endpoint" {
  value       = aws_db_instance.mydb.address
  description = "The public endpoint of the RDS instance."
}

