provider "aws" {}
# }
#   access_key = ""
#   secret_key = ""
#   region     = "us-east-1"
# }


resource "aws_instance" "test_Ubuntu" {
  count         = 1
  ami           = "ami-0574da719dca65348"
  instance_type = "t1.micro"

  tags = {
    Name    = "Ubuntu test Server"
    Owner   = "a.malashenko"
    Project = "Terraform L1"
  }
}

# lifecycle {
#   prevent_destroy = true
# }

# lifecycle {
#   ignore_canges = ["ami", "user_data"]
# }


resource "aws_instance" "test_Amazon" {
  count         = 0
  ami           = "ami-0cdbd57e40d4eec18"
  instance_type = "t1.micro"

  tags = {
    Name    = "Amazon test Server"
    Owner   = "a.malashenko"
    Project = "Terraform L1"
  }
}
