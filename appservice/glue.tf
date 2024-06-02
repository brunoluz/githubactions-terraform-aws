resource "aws_iam_role" "test_glue_role" {
  name = "test_glue_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "glue_policy"
    policy = jsonencode({
      Version = "2012-10-17"    
      Statement = [{
        Action = ["glue:*"]
        Effect   = "Allow"
        Resource = "*"
      }]
    })
  }
}

resource "aws_glue_catalog_database" "glue_db" {
  name = "glue_db"
}

resource "aws_glue_catalog_table" "glue_table" {
  name          = "glue_table"
  database_name = aws_glue_catalog_database.glue_db.name

  storage_descriptor {
    columns {
      name = "event"
      type = "string"
    }
  }
}