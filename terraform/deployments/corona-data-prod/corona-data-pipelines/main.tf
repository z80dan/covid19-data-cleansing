terraform {
  required_version = "= 0.11.13"

  # Comment out when bootstrapping
  backend "s3" {
    bucket = "gds-corona-prod-tfstate"
    key    = "corona-data-pipelines.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["978163229831"]
  region = "eu-west-2"
}

module "coronavirus_data_pipelines" {
  source      = "../../../modules/coronavirus-data-pipelines"

  deployment = "prod"
}
