variable "env" {
  type        = string
  default     = "dev"
  description = "Environment name"
}

variable "ami_id" {
  type        = string
  default     = "ami-0453ec754f44f9a4a" #Linux 3 AMI
  description = "AMI id for ec2 instances"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "type of ec2 instance"
}

variable "key_name" {
  type        = string
  default     = "mykey" #actual key pair name
  description = "key pair name for ssh access"
}

