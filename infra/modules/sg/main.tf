# Create A Security Group For ALB

resource "aws_security_group" "alb" {
  name        = var.alb_sg
  description = "allow all inbound and outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.alb_sg
  }
}

# Create Rules For ALB-sg

resource "aws_vpc_security_group_ingress_rule" "inbound-alb-http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  ip_protocol       = "tcp"
  to_port           = "80"
}

resource "aws_vpc_security_group_ingress_rule" "inbound-alb-https" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "443"
  ip_protocol       = "tcp"
  to_port           = "443"
}

resource "aws_vpc_security_group_egress_rule" "outbound-alb" {
  security_group_id = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.task.id   #or should it be 0.0.0.0/0
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# Create A Security Group For Task

resource "aws_security_group" "task" {
  name        = var.task_sg
  description = "Only allow all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.task_sg
  }
}



# Create Rules For Tasks SG- only traffic from ALB that has alb-sg attached is allowed to reach tasks

resource "aws_vpc_security_group_ingress_rule" "tasks_sg" {
  security_group_id = aws_security_group.task.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port         = var.application_listener_port
  ip_protocol       = "tcp"
  to_port           = var.application_listener_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic" {
  security_group_id = aws_security_group.task.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}





# Make SG for RDS instance

resource "aws_security_group" "rds" {
  name        = var.rds_sg
  description = "allow only inbound traffic from task listening at port 5432"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.rds_sg
  }
}

# Create Rules For RDS SG

resource "aws_vpc_security_group_ingress_rule" "rds_from_app" {
  security_group_id = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.task.id #so only inbound traffic from tasks in both public subnet can form a connection to rds
  from_port         = var.rds_listener_port
  ip_protocol       = "tcp"
  to_port           = var.rds_listener_port
}

resource "aws_vpc_security_group_egress_rule" "rds-to-anywhere" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"              
  ip_protocol       = "-1"      # semantically equivalent to all ports
}







