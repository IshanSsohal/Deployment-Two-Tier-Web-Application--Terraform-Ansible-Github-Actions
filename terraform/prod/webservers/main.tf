terraform {
  required_version = ">= 1.0.0"
}

module "prod-webservers" {
  source        = "../../modules/webservers"
  env           = var.env
  instance_type = var.instance_type
  prefix        = var.prefix
}



