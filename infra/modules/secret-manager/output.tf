output "secret_arn" {
  value = aws_secretsmanager_secret.db.arn
  sensitive = true
}

output "secret_name" {
  value = aws_secretsmanager_secret.db.name
}

output "master_password" {
  value     = random_password.master.result
  sensitive = true
}
