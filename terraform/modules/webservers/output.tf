output "webserver_instance_ids" {
  value = aws_instance.webserver[*].id
}

output "webserver_private_ips" {
  value = aws_instance.webserver[*].private_ip
}

output "webserver_public_ips" {
  value = aws_instance.webserver[*].public_ip
}

