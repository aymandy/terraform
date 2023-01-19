

#----------------------------------------------------------
# My Terraform
#
#Find ami image
#----------------------------------------------------------

#find latest ubuntu
provider "aws" {
  region = "eu-west-1"
}
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.ubuntu.name
}

#----------------------------------------------------------
#find latest amazon linux

data "aws_ami" "lates_windows_2022" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

output "lates_windows_2022_ami_id" {
  value = data.aws_ami.lates_windows_2022.id
}

output "lates_windows_2022_name" {
  value = data.aws_ami.lates_windows_2022.name
}


