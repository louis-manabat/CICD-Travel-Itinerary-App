provider "aws" {
  region = "ap-southeast-2"
}

resource "random_string" "tfstaterand" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "sictfstate" {
  bucket        = "lm-tfstate-${random_string.tfstaterand.result}"
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "TF remote state"
  }
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "lm-locktable-${random_string.tfstatename.result}"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}