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
  default     = "staging"
  type        = string
  description = "Environment"
}