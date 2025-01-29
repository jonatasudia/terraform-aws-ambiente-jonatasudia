#tfsec:ignore:aws-rds-specify-backup-retention 
#tfsec:ignore:builtin.aws.rds.aws0176 
#tfsec:ignore:builtin.aws.rds.aws0177
resource "aws_db_instance" "rds_mysql" {
  depends_on                          = [aws_instance.this]
  allocated_storage                   = 10
  db_name                             = var.database_name
  engine                              = "mysql"
  engine_version                      = "8.0"
  instance_class                      = "db.t3.micro"
  username                            = "admin"
  manage_master_user_password         = true
  parameter_group_name                = "default.mysql8.0"
  skip_final_snapshot                 = true
  performance_insights_enabled        = true
  deletion_protection                 = true
  iam_database_authentication_enabled = true
  performance_insights_kms_key_id     = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

  tags = {
    Env = var.environment
  }

  storage_encrypted = true
}