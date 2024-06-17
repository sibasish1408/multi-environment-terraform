resource "aws_db_instance" "default" {
  allocated_storage    = var.db_allocated_storage[var.environment]
  engine               = "mysql"
  instance_class       = var.db_instance_class[var.environment]
  name                 = "${var.environment}_db"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  tags = {
    Name = "${var.environment}-db"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.environment}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.environment}-subnet-group"
  }
}
