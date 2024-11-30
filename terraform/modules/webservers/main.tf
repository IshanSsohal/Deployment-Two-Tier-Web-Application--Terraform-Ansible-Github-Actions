terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_instance" "webserver" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  key_name      = var.key_name

  # Assign specific names to instances using a lookup map
  tags = {
    Name = lookup(
      {
        0 = "${var.env}-webserver-1"
        1 = "${var.env}-bastion"
        2 = "${var.env}-vm-3"
        3 = "${var.env}-vm-4"
        4 = "${var.env}-vm-5"
        5 = "${var.env}-vm-6"
      },
      count.index,
      "${var.env}-default" # Fallback name if index is out of bounds
    )
    Role = count.index == 1 ? "Bastion" : "Instance"
  }

  # Conditional logic for Bastion Host vs. WebServer
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              ${count.index == 0 || count.index == 4 ? "yum install -y httpd && systemctl start httpd && systemctl enable httpd" : ""}
              EOF

  associate_public_ip_address = count.index < 4 ? true : false

  security_groups = [var.web_sg_id]
}
