provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_course" {
  bucket = "terraform.course-rafe-stefano"
  acl = "private"
}