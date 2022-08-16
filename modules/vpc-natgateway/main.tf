locals {
  vpc_namespace = "VPC_${var.name_vpc}"
}

############################# create VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

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

  tags = {
    Name = "RT_PUBLIC_${local.vpc_namespace}"
  }
}

resource "aws_route" "route_public_internet" {
  route_table_id            = aws_route_table.route_table_public.id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on                = [aws_route_table.route_table_public]
  gateway_id = aws_internet_gateway.gw.id
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

  tags = {
    Name = "RT_PRIVATE_${local.vpc_namespace}"
  }
}

resource "aws_route" "route_public_nat_gateway" {
  count = var.enable_nat_gateway ? 1 : 0
  route_table_id            = aws_route_table.route_table_private.id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on                = [aws_route_table.route_table_private]
  nat_gateway_id  = aws_nat_gateway.ng_main[count.index].id
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
  availability_zone = "us-east-1a"

  tags = {
    Name = "PRIVATE_SUBNET_1_${local.vpc_namespace}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_private_2
  availability_zone = "us-east-1b"
  tags = {
    Name = "PRIVATE_SUBNET_2_${local.vpc_namespace}"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_public_1
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "PUBLIC_SUBNET_1_${local.vpc_namespace}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_public_2
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
    Name = "PUBLIC_SUBNET_2_${local.vpc_namespace}"
  }
}