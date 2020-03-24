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

resource "aws_iam_user" "adam_douglas" {
  name = "adam.douglas"
}

resource "aws_iam_user_policy_attachment" "adam_douglas_admin" {
  user       = "${aws_iam_user.adam_douglas.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "andy_sutton" {
  name = "andy.sutton"
}

resource "aws_iam_user_policy_attachment" "andy_sutton_admin" {
  user       = "${aws_iam_user.andy_sutton.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "paul_groom" {
  name = "paul.groom"
}

resource "aws_iam_user_policy_attachment" "paul_groom_admin" {
  user       = "${aws_iam_user.paul_groom.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "rhydian_page" {
  name = "rhydian.page"
}

resource "aws_iam_user_policy_attachment" "rhydian_page_admin" {
  user       = "${aws_iam_user.rhydian_page.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "thanasis_anthopoulos" {
  name = "thanasis.anthopoulos"
}

resource "aws_iam_user_policy_attachment" "thanasis_anthopoulos_admin" {
  user       = "${aws_iam_user.thanasis_anthopoulos.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "tom_mills" {
  name = "tom.mills"
}

resource "aws_iam_user_policy_attachment" "tom_mills_admin" {
  user       = "${aws_iam_user.tom_mills.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
