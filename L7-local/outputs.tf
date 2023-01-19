#-------------------------------------------
# My terraform
#
# terraform, eip v4.48.0
#-------------------------------------------

output "my_static_ip" {

  value = aws_eip.my_static_ip.public_ip
}
