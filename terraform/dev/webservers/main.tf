terraform {
  required_version = ">= 1.0.0"
}

module "dev-webservers" { ##calling the webserver module here
  source = "../../modules/webservers"
  env           = var.env
  instance_type = var.instance_type
  prefix        = var.prefix
}


  
