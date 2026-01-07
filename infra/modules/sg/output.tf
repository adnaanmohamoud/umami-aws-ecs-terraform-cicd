output "task_sg" {
    description = "Security group ID of the Tasks"
    value = aws_security_group.task.id
}

output "rds_sg" {
  description = "Security group ID of the RDS db postgres"
  value = aws_security_group.rds.id
}

output "alb_sg" {
  description = "Security group ID of the Application Load Balancer"
  value = aws_security_group.alb.id
}

