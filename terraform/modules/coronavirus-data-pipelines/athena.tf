locals {
  nhs_clean_table = "nhs_clean_${var.deployment}"
  ivr_clean_table = "ivr_clean_${var.deployment}"
  web_clean_table = "web_clean_${var.deployment}"
}

data "template_file" "web_clean_query" {
  template = "${file("${path.module}/queries/web-clean.sql")}"

  vars = {
    web_table       = "${aws_glue_catalog_table.web_submissions_s3.name}"
    web_clean_table = "${local.web_clean_table}"
  }
}

resource "aws_athena_named_query" "web_clean" {
  name     = "web-clean-${var.deployment}"
  database = "cv-merged-${var.deployment}"
  query    = "${data.template_file.web_clean_query.rendered}"
}

data "template_file" "ivr_clean_query" {
  template = "${file("${path.module}/queries/ivr-clean.sql")}"

  vars = {
    ivr_table       = "${aws_glue_catalog_table.ivr_submissions_s3.name}"
    ivr_clean_table = "${local.ivr_clean_table}"
  }
}

resource "aws_athena_named_query" "ivr_clean" {
  name     = "ivr-clean-${var.deployment}"
  database = "cv-merged-${var.deployment}"
  query    = "${data.template_file.ivr_clean_query.rendered}"
}

data "template_file" "nhs_clean_query" {
  template = "${file("${path.module}/queries/nhs-clean.sql")}"

  vars = {
    nhs_table       = "${aws_glue_catalog_table.nhs_people_s3.name}"
    nhs_clean_table = "${local.nhs_clean_table}"
  }
}

resource "aws_athena_named_query" "nhs_clean" {
  name     = "nhs-clean-${var.deployment}"
  database = "cv-merged-${var.deployment}"
  query    = "${data.template_file.nhs_clean_query.rendered}"
}

data "template_file" "merge_all_from_clean" {
  template = "${file("${path.module}/queries/merge-all-from-clean.sql")}"

  vars = {
    nhs_clean_table = "${local.nhs_clean_table}"
    ivr_clean_table = "${local.ivr_clean_table}"
    web_clean_table = "${local.web_clean_table}"

    nspl_address_register_table = "${aws_glue_catalog_table.nspl_address_register_s3.name}"
  }
}

resource "aws_athena_named_query" "merge_all_from_clean" {
  name     = "merge-all-from-clean-${var.deployment}"
  database = "cv-merged-${var.deployment}"
  query    = "${data.template_file.merge_all_from_clean.rendered}"
}
