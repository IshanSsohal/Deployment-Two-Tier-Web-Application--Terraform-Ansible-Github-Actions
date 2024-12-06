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
  default     = "staging"
  type        = string
  description = "Environment"
}
variable "azs" {
  description = "List of specific availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

