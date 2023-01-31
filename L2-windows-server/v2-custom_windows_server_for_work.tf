#-------------------------------------------
# My terraform
#
# Build WebServer during Bootsrap
#-------------------------------------------
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "my_windows_L2_server" {
  # count = 1
  ami = "ami-0599be9b02f8c97c6"
  # instance_type = "t3.small"
  instance_type = "t3.large"

  vpc_security_group_ids = [aws_security_group.windows_L2_server_SG.id]

  tags = {
    Name    = "Windows Server L2"
    Owner   = "malashenko"
    Project = "Server for L2"

  }

  # lifecycle {
  #   prevent_destroy = true
  # }

}

resource "aws_security_group" "windows_L2_server_SG" {
  name        = "windows L2 server SG"
  description = "windows L2 server security group"

  ingress { #inbound traffic
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["51.158.175.145/32"]
  }

  ingress { #inbound traffic
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


output "webserver_public_ip_address" {
  value = aws_instance.my_windows_L2_server.public_ip
}
