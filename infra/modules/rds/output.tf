output "hostname" {
  description = "RDS hostname"
  value       = aws_db_instance.rds.address
}

output "port" {
  description = "RDS port"
  value       = aws_db_instance.rds.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.rds.db_name
}

