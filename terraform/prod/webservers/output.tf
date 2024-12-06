output "private_webserver_ip_address" {
  value = module.prod-webservers.private_webserver_ip_address
}

output "vm6_ip_address" {
  value = module.prod-webservers.vm6_ip_address
}
