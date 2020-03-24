// imported resources
// import the dynamo db tables from the IVR and web form

data "aws_dynamodb_table" "ivr_submissions" {
  name = "UKCustomerResponseTable"
}

data "aws_dynamodb_table" "web_submissions" {
  name = "coronavirus-vulnerable-people-${var.deployment}"
}


// created resources
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
