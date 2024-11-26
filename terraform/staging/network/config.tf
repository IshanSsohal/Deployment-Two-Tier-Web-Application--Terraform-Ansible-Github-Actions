terraform {
  backend "s3" {
    bucket = "group-7-staging"               
    key    = "staging/network/terraform.tfstate"  
    region = "us-east-1"                  
  }
}
