locals {
  vpc_namespace = "VPC_${var.name_vpc}"
}

############################# create VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_vpc
  
  tags = {
    Name = "VPC_${var.name_vpc}"
   }
}

############################# create internet gateway
 resource "aws_internet_gateway" "gw" {
   vpc_id = aws_vpc.main.id
   tags = {
     Name = "IG_${local.vpc_namespace}"
   }
 }
############################# route tables
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gw.id
   }

  tags = {
    Name = "RT_PUBLIC_${local.vpc_namespace}"
  }
}

resource "aws_route_table_association" "route_table_public_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "route_table_public_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.main.id

  #  route {
  #    cidr_block = "0.0.0.0/0"
  #    gateway_id = aws_internet_gateway.gw.id
  #  }

  tags = {
    Name = "RT_PRIVATE_${local.vpc_namespace}"
  }
}

resource "aws_route_table_association" "route_table_private_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "route_table_private_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.route_table_private.id
}

############################# create subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_private_1

  tags = {
    Name = "PRIVATE_SUBNET_1_${local.vpc_namespace}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_private_2

  tags = {
    Name = "PRIVATE_SUBNET_2_${local.vpc_namespace}"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_public_1

  tags = {
    Name = "PUBLIC_SUBNET_1_${local.vpc_namespace}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_public_2

  tags = {
    Name = "PUBLIC_SUBNET_2_${local.vpc_namespace}"
  }
}