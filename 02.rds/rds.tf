######################
# RDS parameter group
######################

resource "aws_db_parameter_group" "mysql" {
  name   = "${var.project}-${var.environment}-mysql-parameter-group"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}


######################
# RDS option group
######################

resource "aws_db_option_group" "mysql" {
  name                 = "${var.project}-${var.environment}-mysql-option-group"
  engine_name          = "mysql"
  major_engine_version = "8.0"

  tags = {
    Name        = "${var.project}-${var.environment}-mysql-option-group"
    Project     = var.project
    Environment = var.environment
  }
}


######################
# RDS subnet group
######################

resource "aws_db_subnet_group" "mysql" {
  name = "${var.project}-${var.environment}-mysql-subnet-group"
  subnet_ids = [
    aws_subnet.private_3a.id,
    aws_subnet.private_4c.id
  ]

  tags = {
    Name        = "${var.project}-${var.environment}-mysql-subnet-group"
    Project     = var.project
    Environment = var.environment
  }
}


######################
# RDS instance
######################

resource "random_string" "db_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql" {
  identifier = "${var.project}-${var.environment}-mysql"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t2.micro"

  parameter_group_name = aws_db_parameter_group.mysql.name
  option_group_name    = aws_db_option_group.mysql.name

  multi_az               = false
  availability_zone      = "${var.region}a"
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  port                   = 3306

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  username = "root"
  password = random_string.db_password.result
  name     = ""

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  deletion_protection = true  # 削除時は false
  skip_final_snapshot = false # 削除時は true

  apply_immediately = true

  tags = {
    Name        = "${var.project}-${var.environment}-mysql"
    Project     = var.project
    Environment = var.environment
  }
}
