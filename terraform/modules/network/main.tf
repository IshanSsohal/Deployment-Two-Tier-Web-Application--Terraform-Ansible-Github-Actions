terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "VPC-${var.env}"
  }

}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_cidr_blocks[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    "Name" = "${var.env}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    "Name" = "${var.env}-private-subnet-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "igw-${var.env}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env}-public-route-table"
  }
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-private-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(aws_subnet.private_subnet[*].id)
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

resource "aws_eip" "nat_eip" {

  tags = {
    Name = "${var.env}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.env}-nat-gateway"
  }
}

resource "aws_route" "private_route_nat" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
