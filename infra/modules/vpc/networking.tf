resource "aws_vpc" "url_shortener" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.url_shortener.id
  cidr_block        = var.public_1_cidr
  availability_zone = var.az_1

  tags = {
    Name = "Public subnet 1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.url_shortener.id
  cidr_block        = var.public_2_cidr
  availability_zone = var.az_2

  tags = {
    Name = "Public subnet 2"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.url_shortener.id
  cidr_block        = var.private_1_cidr
  availability_zone = var.az_1

  tags = {
    Name = "Private subnet 1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.url_shortener.id
  cidr_block        = var.private_2_cidr
  availability_zone = var.az_2

  tags = {
    Name = "Private subnet 2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.url_shortener.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.url_shortener.id

  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Internet Gateway Route Table"
  }
}

resource "aws_route_table_association" "public_1_route" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_2_route" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.igw_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.url_shortener.id

  tags = {
    Name = "Private route table"
  }
}

resource "aws_route_table_association" "private_1_route" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_2_route" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_route_table.id
}

