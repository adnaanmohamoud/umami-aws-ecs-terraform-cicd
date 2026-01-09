resource "aws_secretsmanager_secret" "db" {
  name = "db-secrets"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = "dbadmin"
    password = "Ronaldo123"
  })
}

