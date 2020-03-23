terraform {
  required_version = "= 0.11.13"

  # Comment out when bootstrapping
  backend "s3" {
    bucket = "gds-corona-staging-tfstate"
    key    = "ons-users.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["375282846305"]
  region              = "eu-west-2"
}

resource "aws_iam_user" "dan_melluish" {
  name = "dan.melluish"
}

resource "aws_iam_user_policy_attachment" "dan_melluish_admin" {
  user       = "${aws_iam_user.dan_melluish.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
