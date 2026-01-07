variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "priv_subnet_a_name" {
  type = string
  default = "private-subnet-a"
}

variable "priv_subnet_b_name" {
  type = string
  default = "private-subnet-b"
}

variable "public_subnet_a_name" {
  type = string
  default = "public-subnet-a"
}

variable "public_subnet_b_name" {
  type = string
  default = "public-subnet-b"
}

variable "alb_cidr" {
  type = string
  default = "10.0.4.0/24"
}

variable "vpc_name" {
  type = string
  default = "ecs-vpc"
}

variable "igw_name" {
  type = string
  default = "igw"
}

variable "domain" {
  type = string
  default = "vpc"
}

variable "nat_gw" {
  type = string
  default = "NAT-gw"
}

variable "priv_route_table" {
  type = string
  default = "private-route-table"
}

variable "public_subnet_route_table" {
  type = string
  default = "public-subnet-route-table"
}




