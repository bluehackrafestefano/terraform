provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_eip_association" "prod_web" {
  instance_id = aws_instance.prod_web.id
  allocation_id = aws_eip.prod_web.id
}


resource "aws_eip" "prod_web" {
  instance = aws_instance.prod_web.id
  
  tags = {
    "Terraform" = "true"
    "Name" = "Terraform"
  }

}