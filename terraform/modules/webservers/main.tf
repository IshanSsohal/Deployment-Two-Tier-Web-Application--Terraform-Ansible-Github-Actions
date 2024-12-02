terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "group-7-${var.env}" // Bucket from where to GET Terraform State
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1" // Region where bucket created
  }
}
# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}
# Define tags locally
locals {
  default_tags = var.default_tags
  name_prefix  = "${var.env}-${var.prefix}"
}

# Security Groups
# Public webservers security group config
resource "aws_security_group" "public_webservers_sg" {
  name        = "public_webservers_inbound_traffic_rules1"
  description = "Rules for inbound SSH and HTTP traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
    description = "Allow inbound HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow inbound SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.default_tags,
    {
      "Name" = "public-webserver-sg"
    }
  )
}
# Private VMs security group config
resource "aws_security_group" "private_webservers_sg" {
  name        = "private_webservers_inbound_traffic_rules1"
  description = "Rules for inbound SSH traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
    description = "SSH from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.public_webservers[1].private_ip}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.default_tags,
    {
      "Name" = "private-webserver-sg"
    }
  )
}
# Provisioning the private webserver VMs
resource "aws_instance" "private_webservers" {
  count                       = length(data.terraform_remote_state.network.outputs.private_subnet_id)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.private_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.private_subnet_id[count.index]
  associate_public_ip_address = false
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-private-webserver-${count.index + 1}"
    }
  )
}
# Provisioning the public webserver VMs
resource "aws_instance" "public_webservers" {
  count                       = length(data.terraform_remote_state.network.outputs.public_subnet_id)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.public_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id[count.index]
  associate_public_ip_address = true
  user_data = count.index < 2 ? templatefile("${path.module}/install_httpd.sh",
    {
      prefix = upper(var.prefix)
    }
  ) : null
  tags = merge(local.default_tags,
    {
      "Name"  = "${local.name_prefix}-public-webserver-${count.index + 1}",
      "Usage" = count.index >= 2 && count.index <= 3 ? "Ansible" : "Terraform"
    }
  )
}
# Adding SSH key to be used by EC2 instance
resource "aws_key_pair" "ssh_keypair" {
  key_name   = "${var.env}-keypair"
  public_key = file("${path.root}/mykey.pub")
}