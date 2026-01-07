# Create secret manager container

resource "aws_secretsmanager_secret" "db" {
  name = "db-secrets"
}

# Store my database credentials in security manager (does it as version 1)

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = "dbadmin"
    password = "Ronaldo123"
  })
}

