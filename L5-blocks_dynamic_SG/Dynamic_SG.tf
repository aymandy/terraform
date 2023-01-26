#-------------------------------------------
# My terraform
#
# Build dynamic SG terraform v4.48.0
#-------------------------------------------

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "Name_server_SG" {
  name        = "Name server SG"
  description = "Name security group"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "9093"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress = {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name  = "webserver-sg"
    Owner = "a.malashenko"
  }
}
