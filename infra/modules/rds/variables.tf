variable "rds_instance_name" {
  type = string
  default = "umami-rds"
}

variable "name_of_db" {
  type = string
  default = "mydb"
}

variable "rds_subnet_id" {
  type = list(string)
}

variable "rds_sg" {
  type = list(string)
}

variable "db_secret_arn" {
  type = string
}