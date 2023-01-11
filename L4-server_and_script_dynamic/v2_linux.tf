#-------------------------------------------
# My terraform
#
# Build WebServer during Bootsrap
#-------------------------------------------
provider "aws" {
  region = "ap-southeast-2"
}
resource "aws_instance" "my_Linux_L2_server" {
  count                  = 1
  ami                    = "ami-0138de5989ddf0636"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Linux_L2_server_SG.id]
  user_data = templatefile("user_data.tpl", {
    f_name = "Andy",
    l_name = "IM",
    names  = ["Name1", "Name", "John", "Anna", "Vasily"]
  })

  tags = {
    Name    = "Linux Server L2"
    Owner   = "malashenko"
    Project = "Server for L2"

  }
}

resource "aws_security_group" "Linux_L2_server_SG" {
  name        = "Linux L2 server SG"
  description = "Linux L2 server security group"

  ingress { #inbound traffic
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
