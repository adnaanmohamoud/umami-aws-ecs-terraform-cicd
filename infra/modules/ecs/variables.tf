variable "db_host" {
  type        = string
  description = "RDS endpoint hostname"
}

variable "db_port" {
  type        = number
  description = "RDS port"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "task_role_arn" {
  type        = string
  description = "IAM role ARN for ECS task"
}

variable "execution_role_arn" {
  type        = string
  description = "IAM role ARN for ECS execution"
}

variable "alb_tg_arn" {
  type = string
}

variable "task_sg" {
  type = string
}

variable "private_subnet_a" {
  type = string
}

variable "private_subnet_b" {
  type = string
}