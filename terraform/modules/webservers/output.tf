# Add output variables
output "public_webservers_ip_address" {
  value = aws_instance.public_webservers[*].public_ip
}
output "private_webservers_ip_address" {
  value = aws_instance.private_webservers[*].private_ip
}