terraform {
  required_version = "= 0.11.13"

  # Comment out when bootstrapping
  backend "s3" {
    bucket = "gds-corona-staging-tfstate"
    key    = "corona-data-pipelines.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["375282846305"]
  region = "eu-west-2"
}

module "coronavirus_data_pipelines" {
  source      = "../../../modules/coronavirus-data-pipelines"

  deployment = "staging"
}
