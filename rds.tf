provider "aws" {
    region = "us-east-1"
}

resource "aws_db_subnet_group" "rds" {
  name        = length(var.name) == 0 ? "${var.project}-${var.environment}-rds" : var.name
  description = "Our main group of subnets"
  subnet_ids  = var.subnets
}


resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "Admin"
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = ["sg-05b73ee9bfb8855ac"]
  db_subnet_group_name   = aws_db_subnet_group.rds.id
  
  tags = {
    Name        =  length(var.name) == 0 ? "${var.project}-${var.environment}-rds" : var.name
    Environment = var.environment
    Project     = var.project
  }
}
