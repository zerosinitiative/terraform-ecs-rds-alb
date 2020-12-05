resource "aws_db_instance" "test" {
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.username
  password               = var.password
  parameter_group_name   = var.parameter_group_name
  vpc_security_group_ids = [aws_security_group.allow_db.id]
  skip_final_snapshot    = true
}