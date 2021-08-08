provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket         = "lm-tfstate-"
    dynamodb_table = "lm-locktable-"
    key            = "network/terraform.tfstate"
    region         = "ap-southeast-2"
  }
}