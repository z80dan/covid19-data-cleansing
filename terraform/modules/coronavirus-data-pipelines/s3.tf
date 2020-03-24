resource "aws_s3_bucket" "query_results" {
  bucket = "gds-ons-covid-19-query-results-${var.deployment}"
  acl    = "private"
}

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

locals {
  // This should be uploaded to the address register bucket
  address_register_filename = "NSPL_FEB_2020_UK.csv"
}

resource "aws_s3_bucket" "scripts" {
  bucket = "gds-ons-covid-19-scripts-glue-${var.deployment}"
  acl    = "private"
}

data "template_file" "import_web_form_submissions" {
  template = "${file("${path.module}/files/web-form-import.py")}"

  vars = {
    database         = "${aws_glue_catalog_database.merged.name}"
    table_name       = "${aws_glue_catalog_table.web_submissions.name}"
    sink_bucket = "${aws_s3_bucket.web_submissions.bucket}"
  }
}

resource "aws_s3_bucket_object" "import_web_form_submissions" {
  bucket = "${aws_s3_bucket.scripts.bucket}"
  key    = "import-web-form-submissions.py"

  content = "${data.template_file.import_web_form_submissions.rendered}"
  etag    = "${md5(data.template_file.import_web_form_submissions.rendered)}"
}

data "template_file" "import_ivr_submissions" {
  template = "${file("${path.module}/files/ivr-import.py")}"

  vars = {
    database         = "${aws_glue_catalog_database.merged.name}"
    table_name       = "${aws_glue_catalog_table.ivr_submissions.name}"
    sink_bucket = "${aws_s3_bucket.ivr_submissions.bucket}"
  }
}

resource "aws_s3_bucket_object" "import_ivr_submissions" {
  bucket = "${aws_s3_bucket.scripts.bucket}"
  key    = "import-ivr-submissions.py"

  content = "${data.template_file.import_ivr_submissions.rendered}"
  etag    = "${md5(data.template_file.import_ivr_submissions.rendered)}"
}
