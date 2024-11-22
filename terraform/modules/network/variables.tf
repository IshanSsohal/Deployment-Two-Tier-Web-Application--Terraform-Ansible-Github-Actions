variable "env" {
  default     = "dev"
  type        = string
  description = "Environment"
}

variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

variable "public_cidr_blocks" {
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24", "10.1.4.0/24"]
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_cidr_blocks" {
  default     = ["10.1.5.0/24", "10.1.6.0/24"]
  type        = list(string)
  description = "CIDR blocks for private subnets"
}


