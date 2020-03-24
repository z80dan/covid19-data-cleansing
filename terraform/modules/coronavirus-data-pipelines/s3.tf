resource "aws_s3_bucket" "ivr_submissions" {
  bucket = "gds-ons-covid-19-ivr-subs-glue-${var.deployment}"
  acl    = "private"
}

resource "aws_s3_bucket" "web_submissions" {
  bucket = "gds-ons-covid-19-web-subs-glue-${var.deployment}"
  acl    = "private"
}

resource "aws_s3_bucket" "nhs_people" {
  bucket = "gds-ons-covid-19-nhs-people-glue-${var.deployment}"
  acl    = "private"
}

resource "aws_s3_bucket" "address_register" {
  bucket = "gds-ons-covid-19-address-register-glue-${var.deployment}"
  acl    = "private"
}
