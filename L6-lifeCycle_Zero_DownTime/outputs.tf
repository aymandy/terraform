output "webserver_instance_id" {
  value = aws_instance.test_Ubuntu.id
}

output "webserver_public_ip_address" {
  value = aws_eip.my_static_ip.public_ip
}

output "server_SG_id" {
  value       = aws_security_group.test_Ubuntu_SG.id
  description = "it is security group id"
}

output "server_SG_arn" {
  value = aws_security_group.test_Ubuntu_SG.arn
}
