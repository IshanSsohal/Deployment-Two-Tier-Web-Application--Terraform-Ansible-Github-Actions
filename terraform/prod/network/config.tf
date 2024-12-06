terraform {
  backend "s3" {
    bucket = "group-7-prod"               
    key    = "prod/network/terraform.tfstate"  
    region = "us-east-1"                  
  }
}
