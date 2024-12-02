terraform {
  required_version = ">= 1.0.0"
}

module "dev-webservers" {
  source = "../../modules/webservers"
  env    = "dev"
}
