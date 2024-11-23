provider "aws" {
  region = "us-east-1"
}

module "vpc-dev" {
  source              = "../../modules/network/"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_cidr_blocks  = var.public_cidr_blocks
  private_cidr_blocks = var.private_cidr_blocks

}
  