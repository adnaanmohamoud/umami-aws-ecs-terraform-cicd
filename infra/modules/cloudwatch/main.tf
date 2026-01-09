resource "aws_cloudwatch_log_group" "ecs_tasks" {
  name              = var.ecs_log_group_name
  retention_in_days = 14
}

# ECS CPU utilization alarm

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "ECS-CPU-High"
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 2
  threshold           = var.ecs_cpu_threshold
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    ClusterName = "ecs-cluster" 
  }

  alarm_description = "Triggered when ECS task CPU > threshold"
}


# ECS Memory utilization alarm

resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "ECS-Memory-High"
  namespace           = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 2
  threshold           = var.ecs_memory_threshold
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    ClusterName = "ecs-cluster"
  }

  alarm_description = "Triggered when ECS task memory > threshold"
}


