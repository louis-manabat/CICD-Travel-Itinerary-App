output "state_bucket_name" {
  value = aws_s3_bucket.tfstaterand.bucket
}

output "dynamoDb_locktable_name" {
  value = aws_dynamodb_table.terraform_statelock.name
}