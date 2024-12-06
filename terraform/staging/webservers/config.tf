terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }


  backend "s3" {
    bucket = "group-7-staging"                      
    key    = "staging/webservers/terraform.tfstate" 
    region = "us-east-1"
  }
}

