terraform {
  backend "s3" {
    bucket = "group-7-dev"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}
