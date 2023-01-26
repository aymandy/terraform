provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-project-26012023-us-east-1-a.malashenko"
    key    = "dev/sever/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-project-26012023-us-east-1-a.malashenko"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}

#---------------------------------------------------------------------

resource "aws_security_group" "Name_server_SG" {
  name        = "Name server SG"
  description = "Name security group"

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = ["22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr] #cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name  = "webserver-sg"
    Owner = "a.malashenko"
  }
}

#------------------------------------------------

output "network_details" {
  value = data.terraform_remote_state.network
}

output "websrever-sg_id" {
  value = aws_security_group.Name_server_SG.id
}
