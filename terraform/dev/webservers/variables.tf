variable "env" {
  default = "dev"
}

variable "ami_id" {
  default = "ami-0453ec754f44f9a4a" #Linux 3 AMI
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "mykey" #actual key pair name
}

