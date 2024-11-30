# terraform {
#   required_version = ">= 1.0.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

backend "s3" {
  bucket         = "group-7-dev"    # bucket name
  key            = "webservers/terraform.tfstate" # Path to the state file
  region         = "us-east-1"
}
  