variable "env" {
  description = "Environment (dev, prod)"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 6
}

variable "ami_id" {
  description = "AMI ID for the webservers"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the webservers"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair for SSH access"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where webservers will be deployed"
  type        = list(string)
}

variable "web_sg_id" {
  description = "Security group ID for the webservers"
  type        = string
}

