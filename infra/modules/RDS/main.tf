resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "url-shortener-rds-subnet-group"

  subnet_ids = [var.private_subnet_1, var.private_subnet_2]

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage = var.rds_storage

  db_name = var.db_name

  engine         = "postgres"
  engine_version = "17"

  instance_class = var.instance_class

  username = var.rds_username
  password = var.db_password

  vpc_security_group_ids = [
    var.rds_sg
  ]

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot = true

  publicly_accessible = false

  multi_az = true

  storage_encrypted = true

  tags = {
    Name = "URL-RDS"
  }
}

