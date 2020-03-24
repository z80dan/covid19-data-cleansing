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

resource "aws_glue_catalog_table" "ivr_submissions" {
  name          = "cv-ivr-submissions-${var.deployment}"
  database_name = "${aws_glue_catalog_database.merged.name}"

  table_type = "EXTERNAL_TABLE"
  owner      = "owner"

  parameters = {
    "rangeKey"                         = "contact_id"
    "sizeKey"                          = "20288"
    "hashKey"                          = "nhs_number"
    "UPDATED_BY_CRAWLER"               = "test1"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "recordCount"                      = "111"
    "averageRecordSize"                = "182"
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "compressionType"                  = "none"
    "classification"                   = "dynamodb"
    "typeOfData"                       = "table"
  }

  storage_descriptor {
    location = "${data.aws_dynamodb_table.ivr_submissions.arn}"

    input_format  = ""
    output_format = ""

    number_of_buckets = -1

    parameters = {
      "rangeKey"                         = "contact_id"
      "sizeKey"                          = "20288"
      "hashKey"                          = "nhs_number"
      "UPDATED_BY_CRAWLER"               = "test1"
      "CrawlerSchemaSerializerVersion"   = "1.0"
      "recordCount"                      = "111"
      "averageRecordSize"                = "182"
      "CrawlerSchemaDeserializerVersion" = "1.0"
      "compressionType"                  = "none"
      "classification"                   = "dynamodb"
      "typeOfData"                       = "table"
    }

    columns {
      name    = "customer_callling_number"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "nhs_number"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "current_item_id"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "transfer"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "fallback_time"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "nhs_known"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "contact_id"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "call_timestamp"
      type    = "timestamp"
      comment = ""
    }

    columns {
      name    = "nhs_number_2"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "dob"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "dob_2"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "postal_code"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "preferred_phone_number"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "phone_number_calls"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "postal_code_verified"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "delivery_supplies"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "carry_supplies"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "have_help"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "umet_needs"
      type    = "string"
      comment = ""
    }
  }
}

resource "aws_glue_job" "import_ivr_submissions" {
  name     = "cv-import-ivr-submissions-${var.deployment}"
  role_arn = "${aws_iam_role.glue.arn}"

  command {
    script_location = "s3://${aws_s3_bucket.scripts.bucket}/${aws_s3_bucket_object.import_ivr_submissions.key}"
    python_version  = 3
  }
}

resource "aws_glue_catalog_table" "ivr_submissions_s3" {
  name          = "cv-ivr-submissions-s3-${var.deployment}"
  database_name = "${aws_glue_catalog_database.merged.name}"

  table_type = "EXTERNAL_TABLE"
  owner      = "owner"

  parameters = {
    "sizeKey"                          = "38735"
    "objectCount"                      = "20"
    "UPDATED_BY_CRAWLER"               = "ukcustomerresponsetable_to_athena"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "recordCount"                      = "111"
    "averageRecordSize"                = "343"
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "compressionType"                  = "none"
    "classification"                   = "json"
    "typeOfData"                       = "file"
  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.ivr_submissions.bucket}/sink/"

    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    number_of_buckets = -1

    ser_de_info {
      name                  = "json"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"

      parameters = {
        paths = "call_timestamp,carry_supplies,contact_id,current_item_id,customer_callling_number,delivery_supplies,dob,fallback_time,have_help,nhs_known,nhs_number,phone_number_calls,postal_code,postal_code_verified,preferred_phone_number,transfer,umet_needs"
      }
    }

    columns {
      name    = "customer_callling_number"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "nhs_number"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "current_item_id"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "transfer"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "fallback_time"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "nhs_known"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "contact_id"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "dob"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "postal_code"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "preferred_phone_number"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "phone_number_calls"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "postal_code_verified"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "delivery_supplies"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "carry_supplies"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "have_help"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "call_timestamp"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "umet_needs"
      type    = "string"
      comment = ""
    }
  }
}

resource "aws_glue_catalog_table" "nhs_people_s3" {
  name          = "cv-nhs-people-s3-${var.deployment}"
  database_name = "${aws_glue_catalog_database.merged.name}"

  table_type = "EXTERNAL_TABLE"
  owner      = "owner"

  parameters = {
    "skip.header.line.count"           = "1"
    "sizeKey"                          = "609"
    "objectCount"                      = "1"
    "UPDATED_BY_CRAWLER"               = "nhs_staging_crawler"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "recordCount"                      = "2"
    "averageRecordSize"                = "208"
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "compressionType"                  = "none"
    "classification"                   = "csv"
    "columnsOrdered"                   = "true"
    "areColumnsQuoted"                 = "false"
    "delimiter"                        = ","
    "typeOfData"                       = "file"
  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.nhs_people.bucket}/"

    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    number_of_buckets = -1

    ser_de_info {
      name                  = "json"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "field.delim" = ","
      }
    }

    // columns
    columns {
      name    = "nhsnumber"
      type    = "bigint"
      comment = ""
    }

    columns {
      name    = "dateofbirth"
      type    = "bigint"
      comment = ""
    }

    columns {
      name    = "patienttitle"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientfirstname"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientothername"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientsurname"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientaddress_line1"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientaddress_line2"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientaddress_line3"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientaddress_line4"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientaddress_line5"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "patientaddress_postcode"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "practice_code"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "practice_name"
      type    = "string"
      comment = ""
    }

    columns {
      name    = "contact_telephone"
      type    = "bigint"
      comment = ""
    }
  }
}
