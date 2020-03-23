resource "aws_dynamodb_table" "dirty_merge" {
  name           = "corona-data-pipelines-dirty-merge-${var.deployment}"

  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "NHSNumber"
    type = "S"
  }

  hash_key       = "NHSNumber"
}

output "dirty_merge_db_table_name" {
  value = "${aws_dynamodb_table.dirty_merge.name}"
}

resource "aws_dynamodb_table" "clean_merge" {
  name           = "corona-data-pipelines-clean-merge-${var.deployment}"

  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "NHSNumber"
    type = "S"
  }

  hash_key       = "NHSNumber"
}

output "clean_merge_db_table_name" {
  value = "${aws_dynamodb_table.clean_merge.name}"
}
