resource "aws_glue_catalog_database" "glue_db" {
  name = "glue_db"
}

resource "aws_glue_catalog_table" "glue_table" {
  name          = "glue_table"
  database_name = aws_glue_catalog_database.glue_db.name
}