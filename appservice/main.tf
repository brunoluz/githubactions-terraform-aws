provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "brunoluz-terraform-states-control" {
  bucket = "brunoluz-terraform-states-control"
}