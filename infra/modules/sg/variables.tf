variable "vpc_id" {
  type = string
}

variable "task_sg" {
  type = string
  default = "task_sg"
}

variable "application_listener_port" {
  type = number
  default = "3000"
}

variable "alb_sg" {
    type = string
    default = "alb_sg" 
}

variable "rds_sg" {
  type = string
  default = "rds_sg"
}

variable "rds_listener_port" {
  type = number
  default = "5432"
}





