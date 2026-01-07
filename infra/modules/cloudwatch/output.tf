output "ecs_log_group_name" {
  value       = aws_cloudwatch_log_group.ecs_tasks.name
  description = "The ECS log group name"
}

output "ecs_cpu_alarm" {
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.id
  description = "ECS CPU high utilization alarm"
}

output "ecs_memory_alarm" {
  value       = aws_cloudwatch_metric_alarm.ecs_memory_high.id
  description = "ECS memory high utilization alarm"
}
