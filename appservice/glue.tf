resource "aws_s3_bucket" "s3_glue_db" {
  bucket = "s3-glue-db"
}

resource "aws_glue_catalog_database" "glue_db" {
  name = "glue_db"
}

resource "aws_glue_catalog_table" "glue_table" {
  name          = "glue_table_iceberg"
  database_name = aws_glue_catalog_database.glue_db.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    "table_type" = "ICEBERG"
    "format"     = "parquet"
  }

  open_table_format_input {
    iceberg_input {
      metadata_operation = "CREATE"
    }
  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.s3_glue_db.bucket}/${aws_glue_catalog_database.glue_db.name}/glue_table_iceberg"
    # input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    # output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    columns {
      name = "event"
      type = "string"
    }
  }
}
