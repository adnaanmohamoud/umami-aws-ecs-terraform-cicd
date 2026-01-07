variable "ecs_log_group_name" {
  type        = string
  description = "CloudWatch log group name for ECS task logs"
  default     = "/ecs/umami"
}

variable "ecs_cpu_threshold" {
  type        = number
  description = "CPU utilization percentage to trigger ECS alarm"
  default     = 80
}

variable "ecs_memory_threshold" {
  type        = number
  description = "Memory utilization percentage to trigger ECS alarm"
  default     = 80
}


