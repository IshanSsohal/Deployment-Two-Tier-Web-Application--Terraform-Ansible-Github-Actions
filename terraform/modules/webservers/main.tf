terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "terraform_remote_state" "network" { 
  backend = "s3"
  config = {
    bucket = "group-7-${var.env}"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  default_tags = var.default_tags
  name_prefix  = "${var.env}-${var.prefix}"
}

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

  tags = merge(local.default_tags, {
    "Name" = "public-webserver-sg"
  })
}

resource "aws_security_group" "private_webservers_sg" {
  name        = "private_webservers_inbound_traffic_rules1"
  description = "Rules for inbound SSH traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description = "SSH from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    "Name" = "private-webserver-sg"
  })
}

# Bastion Host - Static instance
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.public_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id[1]
  associate_public_ip_address = true
  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}-bastion"
  })
}

resource "aws_instance" "private_webservers" {
  count                       = length(data.terraform_remote_state.network.outputs.private_subnet_id)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.private_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.private_subnet_id[count.index]
  availability_zone           = var.azs[count.index]
  associate_public_ip_address = false
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-private-webserver-${count.index + 1}"
    }
  )
}
# Webserver 4 - 
resource "aws_instance" "webserver_4" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.public_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id[3]
  associate_public_ip_address = true
  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}-webserver-4"
  })
}

# Launch Template for ASG (Webserver 1 and 3)
resource "aws_launch_template" "webserver_launch_template" {
  name_prefix   = "${var.env}-webserver-launch-template"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_keypair.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.public_webservers_sg.id]
  }

  user_data = base64encode(templatefile("${path.module}/install_httpd.sh", {
    prefix = upper(var.prefix)
  }))

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.default_tags, {
      "Name" = "${local.name_prefix}-webserver-temp"
    })
  }
}

# Auto Scaling Group for Webserver 
resource "aws_autoscaling_group" "webserver_asg" {
  launch_template {
    id      = aws_launch_template.webserver_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = slice(data.terraform_remote_state.network.outputs.public_subnet_id, 0, 3)
  desired_capacity    = 3
  min_size            = 1
  max_size            = 4

  target_group_arns = [aws_lb_target_group.webserver_tg.arn]

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-webserver"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "webserver_lb" {
  name               = "${var.env}-webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_webservers_sg.id]
  subnets            = data.terraform_remote_state.network.outputs.public_subnet_id

  enable_deletion_protection = false
  tags = local.default_tags
}

resource "aws_lb_listener" "webserver_http_listener" {
  load_balancer_arn = aws_lb.webserver_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.webserver_tg.arn
  }
}

resource "aws_lb_target_group" "webserver_tg" {
  name        = "${var.env}-webserver-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  
  stickiness {
    type = "lb_cookie"
    enabled = false
  }

  tags = local.default_tags
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.env}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description = "Allow HTTP traffic from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}

resource "aws_key_pair" "ssh_keypair" {
  key_name   = "${var.env}-keypair"
  public_key = file("${path.root}/${var.env}-keypair.pub")
}
