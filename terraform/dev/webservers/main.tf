# pulling data from the remote state of the network module
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "group-7-dev"  #S3 bucket name
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}


# Create a Security Group for WebServers
resource "aws_security_group" "web_sg" {
  name_prefix = "${var.env}-web-sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "${var.env}-web-sg"
  }
}

# Use the webservers module
module "webservers" {
  source          = "../../modules/webservers"
  env             = var.env
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  instance_count  = 6

  # Fetch public and private subnet IDs from the remote state
  subnet_ids      = concat(
    data.terraform_remote_state.network.outputs.public_subnet_id,
    data.terraform_remote_state.network.outputs.private_subnet_id
  )

  # Pass the Security Group ID
  web_sg_id       = aws_security_group.web_sg.id
}
