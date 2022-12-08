provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"
  
  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mybucket_encryption" {
  bucket = aws_s3_bucket.mybucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}