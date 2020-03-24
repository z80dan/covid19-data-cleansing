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
