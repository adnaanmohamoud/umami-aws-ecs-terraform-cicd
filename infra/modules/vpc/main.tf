resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}



# Create Private Subnet A For ECS Tasks and RDS

resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = var.priv_subnet_a_name
  }
}


# Create Private Subnet B

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = var.priv_subnet_b_name
  }
}


# Create Public Subnet A For ALB AND NAT Gateway

resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true    #gives every resource in public subnet a public ip

  tags = {
    Name = var.public_subnet_a_name
  }
}



# Create A Public Subnet B For ALB

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_b_name
  }
}


# Create An Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.igw_name
  }
}


# Create An Elastic IP For NAT GW

resource "aws_eip" "nat" {
  domain   = var.domain
}


# Create A NAT Gateway

resource "aws_nat_gateway" "NAT_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = var.nat_gw
  }

  depends_on = [aws_internet_gateway.igw]
}



# Create a Private Route Table for Private Subnets- i am going to make this route table to be shared amongst the private subnets 

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"     # its basically saying, if traffic is destined to anywhere within the vpc send it there otherwise if the computer is on the internet, send traffic to the nat gw, in this case task can send traffic to db as its local (Within vpc)
    nat_gateway_id = aws_nat_gateway.NAT_gateway.id
  }

  tags = {
    Name = var.priv_route_table
  }
}


# Create a Public Route Table 

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_subnet_route_table
  }
}


# Associate Private Subnet A To privateRoutetable1

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table.id
}


# Associate Private Subnet B To privateRoutetable1

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table.id
}

# Associate Public Subnet A To publicRouteTable

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}


# Associate Public Subnet B To Public Route Table

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}