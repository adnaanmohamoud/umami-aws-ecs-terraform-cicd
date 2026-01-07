variable "vpc_id" {
  type = string
}

variable "alb_sg" {
  type = string
}

variable "public_subnet_a" {
  type = string
}

variable "public_subnet_b" {
  type = string
}

variable "alb_name" {
  type = string
  default = "my-alb"
}

variable "application_listening_port" {
  type = number
  default = "3000"
}

variable "acm_certificate_arn" {
  type = string
}

variable "health_check_path" {
  type = string
}