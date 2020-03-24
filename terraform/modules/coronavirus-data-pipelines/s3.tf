resource "aws_s3_bucket" "ivr_submissions" {
  bucket = "gds-ons-covid-19-ivr-subs-glue-${var.deployment}"
  acl    = "private"
}

resource "aws_s3_bucket" "web_submissions" {
  bucket = "gds-ons-covid-19-web-subs-glue-${var.deployment}"
  acl    = "private"
}
