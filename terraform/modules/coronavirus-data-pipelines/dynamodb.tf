// imported resources
// import the dynamo db tables from the IVR and web form
data "aws_dynamodb_table" "ivr_submissions" {
  name = "UKCustomerResponseTable"
}

data "aws_dynamodb_table" "web_submissions" {
  name = "coronavirus-vulnerable-people-${var.deployment}"
}
