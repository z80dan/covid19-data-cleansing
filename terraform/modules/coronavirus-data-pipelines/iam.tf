resource "aws_iam_role" "glue" {
  name = "coronavirus-data-glue"

  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "glue_can_do_glue" {
  role       = "${aws_iam_role.glue.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "glue_dynamo_db" {
  name        = "glue-dynamo-db-${var.deployment}"
  description = "Role for Glue to scan DynamoDB"

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:DescribeTable",
        "dynamodb:Scan"
      ],
      "Resource": "*"
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "glue_can_do_dynamo" {
  role       = "${aws_iam_role.glue.name}"
  policy_arn = "${aws_iam_policy.glue_dynamo_db.arn}"
}

resource "aws_iam_policy" "glue_s3" {
  name        = "glue-s3-${var.deployment}"
  description = "Role for Glue to use S3"

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.ivr_submissions.arn}",
        "${aws_s3_bucket.ivr_submissions.arn}/*",
        "${aws_s3_bucket.web_submissions.arn}",
        "${aws_s3_bucket.web_submissions.arn}/*",
        "${aws_s3_bucket.nhs_people.arn}",
        "${aws_s3_bucket.nhs_people.arn}/*",
        "${aws_s3_bucket.scripts.arn}",
        "${aws_s3_bucket.scripts.arn}/*",
        "${aws_s3_bucket.query_results.arn}",
        "${aws_s3_bucket.query_results.arn}/*",
        "${aws_s3_bucket.address_register.arn}",
        "${aws_s3_bucket.address_register.arn}/*"
      ]
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "glue_can_do_s3" {
  role       = "${aws_iam_role.glue.name}"
  policy_arn = "${aws_iam_policy.glue_s3.arn}"
}
