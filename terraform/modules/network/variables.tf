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
