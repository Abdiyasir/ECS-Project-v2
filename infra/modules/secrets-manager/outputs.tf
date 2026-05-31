output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "secret_arn" {
  value     = aws_secretsmanager_secret.database_url.arn
}