terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.52.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      managed-by = "terraform"
    }
  }
}

resource "aws_s3_bucket" "brunoluz-terraform-states-control" {
  bucket = "brunoluz-terraform-states-control"
}
