# Create RDS Instance

resource "aws_db_instance" "rds" {
  
  identifier = var.rds_instance_name    #this is the name of the rds instance (like a server that has many db)  
  engine               = "postgres"
  engine_version       = "17.6"

  allocated_storage    = 20 
  instance_class       = "db.t3.micro"

  db_name              = var.name_of_db     # this is the name of the first database made by terraform
  username             = local.db_creds.username
  password             = local.db_creds.password

  skip_final_snapshot  = true   # a snapshot wont be taken of the db once deleted, saves money

  publicly_accessible = false

  db_subnet_group_name = aws_db_subnet_group.rds.name

  vpc_security_group_ids = var.rds_sg

  

  tags = {
    Name = var.rds_instance_name
  }
}

# Create a Subnet group (its just a collection of private subnets where ur aws can put ur db in)

resource "aws_db_subnet_group" "rds" {
  name       = "rds"
  subnet_ids = var.rds_subnet_id

  tags = {
    Name = "rds in these private subnets"
  }
}


# Read secret using data blocks

data "aws_secretsmanager_secret" "db" {
  arn = var.db_secret_arn
}

data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

# Decode JSON

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)
}
