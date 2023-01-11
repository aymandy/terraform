#-------------------------------------------
# My terraform
#
# Build dynamic SG terraform, eip v4.48.0
#-------------------------------------------

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.test_Ubuntu.id
}

resource "aws_instance" "test_Ubuntu" {
  # count         = 1
  ami           = "ami-0138de5989ddf0636"
  instance_type = "t1.micro"

  tags = {
    Name    = "Ubuntu test Server"
    Owner   = "a.malashenko"
    Project = "Terraform"
  }

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Andy",
    l_name = "IM",
    names  = ["Name1", "Name", "John", "Anna", "Vasily"]
  })

  vpc_security_group_ids = [aws_security_group.test_Ubuntu_SG.id]


  lifecycle {
    create_before_destroy = true
  }
  # installing dependencies
  # depends_on = [associate_public_ip_address.my_static_ip]
  # or
  # depends_on = [aws_instance.name_instatse1,aws_instance.name_instatse2]

}

resource "aws_security_group" "test_Ubuntu_SG" {
  name        = "Name server SG"
  description = "Name security group"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "3389"]
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

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
