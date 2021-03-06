provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_security_group" "prod_web2" {
  name = "prod_web"
  description = "Allow http/s inbound traffic"

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" = "true"
  }

}