variable "ecs_task_role_name" {
  type = string
  default = "ecs-task-role"
  description = "IAM role name for ECS task role"
}

variable "ecs_execution_role_name" {
  type = string
  default = "ecs-execution-role"
  description = "IAM role name for ECS execution role"
}



