

#----------------------------------------------------------
# My Terraform
#
#Cycle
#----------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

variable "aws_users" {
  description = "List of IAM Users to create"
  default     = ["user1", "user2", "user3", "user_4", "user_5", "user6", "user7"]
}


resource "aws_iam_user" "name_user_1" {
  name = "user_test_1"
}

resource "aws_iam_user" "user1" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}
