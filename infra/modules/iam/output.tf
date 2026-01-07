output "ecs_task_role_arn" {
  description = "IAM role ARN assumed by the ECS task"
  value       = aws_iam_role.ecs_task_role.arn
}

output "ecs_execution_role_arn" {
  description = "IAM role ARN used by ECS for pulling images and logs"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_name" {
  value = aws_iam_role.ecs_task_role.name
}
