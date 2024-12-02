# variable "env" {
#   type        = string
#   default     = "dev"
#   description = "Environment name"
# }

# variable "ami_id" {
#   type        = string
#   default     = "ami-0453ec754f44f9a4a" #Linux 3 AMI
#   description = "AMI id for ec2 instances"
# }
# variable "key_name" {
#   type        = string
#   default     = "mykey" #actual key pair name
#   description = "key pair name for ssh access"
# }
# Instance type
variable "instance_type" {
  default     = "t2.micro"
  type        = string
  description = "instance type"
}
# Prefix to identify resources
variable "prefix" {
  default     = "group7"
  type        = string
  description = "Name prefix"
}

variable "env" {
  default     = "dev"
  type        = string
  description = "Environment"
}