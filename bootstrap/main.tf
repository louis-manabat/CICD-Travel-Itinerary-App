provider "aws" {
  region = "ap-southeast-2"
}

resource "random_string" "tfstaterand" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "sictfstate" {
  bucket        = "sic-tfstate-${random_string.tfstaterand.result}"
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "TF remote state"
  }
}