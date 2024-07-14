resource "aws_s3_bucket" "s3_glue_db" {
  bucket        = "s3-glue-db"
  force_destroy = true
}

resource "aws_glue_catalog_database" "glue_db" {
  name = "glue_db"
}

resource "aws_glue_catalog_table" "glue_table" {
  name          = "iceberg_test"
  database_name = aws_glue_catalog_database.glue_db.name

  table_type = "EXTERNAL_TABLE"

  open_table_format_input {
    iceberg_input {
      metadata_operation = "CREATE"
    }
  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.s3_glue_db.bucket}/${aws_glue_catalog_database.glue_db.name}/glue_table_iceberg"
    columns {
      name = "new_column_1"
      type = "string"
    }

    columns {
      name = "new_column_2"
      type = "string"
    }
  }
}
