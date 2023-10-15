resource "aws_vpc" "vpc" {
  cidr_block            = var.vpc_cidr_block

  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name  = "${var.project}-${var.environment}-${var.vpc_name}"
    Env   = var.environment
  }
}

resource "aws_subnet" "public_subnets" {
  count      = "${length(var.public_subnet_num)}"
  vpc_id     = aws_vpc.vpc.id
  cidr_block = [
                  for num in var.public_subnet_num:
                  cidrsubnet(aws_vpc.vpc.cidr_block, 8, num)
                ][count.index]
  tags = {
    Name = "${var.project}-${var.environment}-pb-sbn"
    Env = var.environment
  }
}

resource "aws_subnet" "private_subnets" {
  count      = "${length(var.private_subnet_num)}"
  vpc_id     = aws_vpc.vpc.id
  cidr_block = [
                  for num in var.private_subnet_num:
                    cidrsubnet(aws_vpc.vpc.cidr_block, 8, num)
                ][count.index]
  tags = {
    Name = "${var.project}-${var.environment}-pv-sbn"
    Env = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-igw"
    Env = var.environment
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-${var.environment}-pb-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  # route {
  #   cidr_block = "10.0.1.0/24"
  #   gateway_id = aws_internet_gateway.example.id
  # }

  tags = {
    Name = "${var.project}-${var.environment}-pv-rt"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_asso" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat_ip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.private_subnets[0].id

  tags = {
    Name = "${var.project}-${var.environment}-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}