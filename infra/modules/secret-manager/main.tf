resource "aws_secretsmanager_secret" "db" {
  name = "db-secrets"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.master.result
  })
}

resource "random_password" "master" {
  length  = 12
  upper   = true
  lower   = true
  numeric = true
  special = false

}
