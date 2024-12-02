# Add output variables
output "public_webservers_ip_address" {
  value = module.dev-webservers.public_webservers_ip_address
}

output "private_webservers_ip_address" {
  value = module.dev-webservers.private_webservers_ip_address
}