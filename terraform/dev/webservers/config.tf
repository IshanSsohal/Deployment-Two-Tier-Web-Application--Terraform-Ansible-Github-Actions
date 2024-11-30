terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "group-7-dev"
    key            = "webservers/terraform.tfstate"
    region         = "us-east-1"
  }
}

