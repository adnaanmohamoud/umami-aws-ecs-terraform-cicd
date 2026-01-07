variable "log_group_name" {
  type        = string
  description = "CloudWatch log group for ECS task logs"
}

variable "log_stream_prefix" {
  type        = string
  description = "Log stream prefix for ECS tasks"
  default     = "ecs"
}

