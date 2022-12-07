provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "bruno-bucket-xpto"

  # Tells AWS to encrypt the S3 bucket at rest by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

 tags = {
    Terraform = "true"
  }
}