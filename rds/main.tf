resource "aws_db_subnet_group" "db_subnet_group" {
  name = "gym-partner-staging-db-subnet-group"
  subnet_ids = var.public_subnet_ids
}

resource "aws_security_group" "rds_sg" {
  name = "rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "staging-postgres"
  engine = "postgres"
  engine_version = "17.4"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  storage_type = "gp2"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 0
  multi_az = false

  tags = {
    Name = "rds-postgres"
  }
}