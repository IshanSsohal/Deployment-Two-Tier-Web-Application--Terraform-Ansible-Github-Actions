output "private_webserver_ip_address" {
  value = aws_instance.private_webserver.private_ip
}
output "vm6_ip_address" {
  value = aws_instance.vm6.private_ip
}
