

#----------------------------------------------------------
# My Terraform
#
# use remote state
#----------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-project-26012023-us-east-1-a.malashenko"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}

#--------------------------------------------------------

variable "aws_cidr" {
  default = "10.0.0.0/16"
}


resource "aws_vpc" "main-am" {
  cidr_block = var.aws_cidr
  tags = {
    Name = "a.malashenko-vpc-test"
  }
}

resource "aws_internet_gateway" "main-am" {
  vpc_id = aws_vpc.main-am.id
  tags = {
    Name = "a.malashenko-igw"
  }
}


#---------------------------------------------------------

output "vpc_id" {
  value = aws_vpc.main-am.id
}

output "vpc_cidr" {
  value = aws_vpc.main-am.cidr_block
}
