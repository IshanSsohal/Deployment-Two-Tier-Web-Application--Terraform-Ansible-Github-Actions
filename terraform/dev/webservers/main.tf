# pulling data from the remote state of the network module
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "group-7-dev" #S3 bucket name
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}


module "dev-webservers" {
  source = "../../modules/webservers"
  env    = "dev"
}
