output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.my_vpc.id
}

output "private_subnet_a" {
  description = "ID of private subnet a"
  value = aws_subnet.private_subnet_a.id
}

output "private_subnet_b" {
  description = "ID of private subnet b"
  value = aws_subnet.private_subnet_b.id
}

output "public_subnet_a" {
  description = "ID of public subnet a"
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_b" {
  description = "ID of public subnet b"
  value = aws_subnet.public_subnet_b.id
}

# I need to ouput subnet's cidr because some modules like sg uses cidr instead of the subnet's id

output "private_subnet_a_cidr" {
  description = "CIDR of private subnet a"
  value = aws_subnet.private_subnet_a.cidr_block
}

output "private_subnet_b_cidr" {
  description = "CIDR of private subnet b"
  value = aws_subnet.private_subnet_b.cidr_block
}

output "public_subnet_a_cidr" {
  description = "CIDR of public subnet a"
  value = aws_subnet.public_subnet_a.cidr_block
}

output "public_subnet_b_cidr" {
  description = "CIDR of public subnet b"
  value = aws_subnet.public_subnet_b.cidr_block
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}