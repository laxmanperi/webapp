resource "aws_db_subnet_group" "rds" {
  name        = length(var.name) == 0 ? "${var.project}-${var.environment}${var.tag}-rds" : var.name
  description = "Our main group of subnets"
  subnet_ids  = var.subnets
}


resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = var.multi_az
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.id
  monitoring_interval    = var.monitoring_interval
  
  tags = {
    Name        =  length(var.name) == 0 ? "${var.project}-${var.environment}${var.tag}-rds" : var.name
    Environment = var.environment
    Project     = var.project
  }
}
