resource "aws_glue_catalog_database" "merged" {
  name = "cv-merged-${var.deployment}"
}

resource "aws_glue_catalog_table" "web_submissions" {
  name          = "cv-web-submissions-${var.deployment}"
  database_name = "${aws_glue_catalog_database.merged.name}"

  table_type = "EXTERNAL_TABLE"
  owner      = "owner"

  parameters = {
    "rangeKey"                         = "UnixTimestamp"
    "sizeKey"                          = "6495"
    "hashKey"                          = "ReferenceId"
    "UPDATED_BY_CRAWLER"               = "coronavirus-vulnerable-people-crawler"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "recordCount"                      = "14"
    "averageRecordSize"                = "463"
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "compressionType"                  = "none"
    "classification"                   = "dynamodb"
    "typeOfData"                       = "table"
  }

  storage_descriptor {
    location = "${data.aws_dynamodb_table.web_submissions.arn}"

    input_format  = ""
    output_format = ""

    number_of_buckets = -1

    parameters = {
      "rangeKey"                         = "UnixTimestamp"
      "sizeKey"                          = "6495"
      "hashKey"                          = "ReferenceId"
      "UPDATED_BY_CRAWLER"               = "coronavirus-vulnerable-people-crawler"
      "CrawlerSchemaSerializerVersion"   = "1.0"
      "recordCount"                      = "14"
      "averageRecordSize"                = "463"
      "CrawlerSchemaDeserializerVersion" = "1.0"
      "compressionType"                  = "none"
      "classification"                   = "dynamodb"
      "typeOfData"                       = "table"
    }

    columns {
      name    = "formresponse"
      type    = "struct<live_in_england:string,support_address:struct<town_city:string,building_and_street_line_2:string,county:string,postcode:string,building_and_street_line_1:string>,carry_supplies:string,nhs_number:string,reference_id:string,date_of_birth:struct<month:string,year:string,day:string>,session_id:string,_csrf_token:string,contact_details:struct<phone_number_calls:string,phone_number_texts:string,email:string>,know_nhs_number:string,check_answers_seen:boolean,nhs_letter:string,basic_care_needs:string,name:struct<last_name:string,middle_name:string,first_name:string>,dietary_requirements:string,medical_conditions:string,essential_supplies:string>"
      comment = ""
    }

    columns {
      name    = "updated_at"
      type    = "double"
      comment = ""
    }

    columns {
      name    = "referenceid"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "unixtimestamp"
      type    = "double"
      comment = ""
    }

    columns {
      name    = "created_at"
      type    = "double"
      comment = ""
    }
  }
}

resource "aws_glue_job" "import_web_submissions" {
  name     = "cv-import-web-submissions-${var.deployment}"
  role_arn = "${aws_iam_role.glue.arn}"

  command {
    script_location = "s3://${aws_s3_bucket.scripts.bucket}/${aws_s3_bucket_object.import_web_form_submissions.key}"
    python_version  = 3
  }
}

resource "aws_glue_catalog_table" "web_submissions_s3" {
  name          = "cv-web-submissions-s3-${var.deployment}"
  database_name = "${aws_glue_catalog_database.merged.name}"

  table_type = "EXTERNAL_TABLE"
  owner      = "owner"

  parameters = {
    "rangeKey"                         = "UnixTimestamp"
    "sizeKey"                          = "6495"
    "hashKey"                          = "ReferenceId"
    "UPDATED_BY_CRAWLER"               = "coronavirus-vulnerable-people-crawler"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "recordCount"                      = "14"
    "averageRecordSize"                = "463"
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "compressionType"                  = "none"
    "classification"                   = "dynamodb"
    "typeOfData"                       = "table"
  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.web_submissions.bucket}/sink/"

    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    number_of_buckets = -1

    ser_de_info {
      name                  = "json"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"

      parameters = {
				"paths" = "created_at,formresponse,referenceid,unixtimestamp,updated_at"
      }
    }

    columns {
      name    = "formresponse"
      type    = "struct<live_in_england:string,support_address:struct<town_city:string,building_and_street_line_2:string,county:string,postcode:string,building_and_street_line_1:string>,carry_supplies:string,nhs_number:string,reference_id:string,date_of_birth:struct<month:string,year:string,day:string>,session_id:string,_csrf_token:string,contact_details:struct<phone_number_calls:string,phone_number_texts:string,email:string>,know_nhs_number:string,check_answers_seen:boolean,nhs_letter:string,basic_care_needs:string,name:struct<last_name:string,middle_name:string,first_name:string>,dietary_requirements:string,medical_conditions:string,essential_supplies:string>"
      comment = ""
    }

    columns {
      name    = "updated_at"
      type    = "double"
      comment = ""
    }

    columns {
      name    = "referenceid"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "unixtimestamp"
      type    = "double"
      comment = ""
    }

    columns {
      name    = "created_at"
      type    = "double"
      comment = ""
    }
  }
}
