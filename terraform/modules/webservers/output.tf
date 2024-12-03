output "private_webservers_ip_address" {
  value = aws_instance.private_webservers[*].private_ip
}