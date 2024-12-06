output "private_webserver_ip_address" {
  value = module.staging-webservers.private_webserver_ip_address
}

output "vm6_ip_address" {
  value = module.staging-webservers.vm6_ip_address
}
