resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "database_url" {
  name = "url-rds-password"
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = "postgresql://${var.rds_username}:${random_password.db_password.result}@${var.rds_address}:${var.rds_port}/${var.db_name}"
}
