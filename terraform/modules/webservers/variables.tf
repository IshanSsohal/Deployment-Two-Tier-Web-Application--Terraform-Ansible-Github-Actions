# Instance type
variable "instance_type" {
  default     = "t2.micro"
  type        = string
  description = "instance type"
}

# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Group7"
    "App"   = "WebApp"
  }
  type        = map(any)
  description = "Default tags for all resources created in AWS"
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