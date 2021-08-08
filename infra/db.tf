resource "aws_dynamodb_table" "ddb-user-table" {
  name = "users"
  billing_mode = "PROVISIONED"
  read_capacity = 10
  write_capacity = 10
  hash_key = "email"

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name = "Users_Email"
    hash_key = "email"
    projection_type = "ALL"
    read_read_capacity = 10
    write_capacity = 10
  }

  tags = {
      Name = "Simple Travel Itinerary App - User"
  }
}

resource "aws_dynamodb_table" "ddb-locations-table" {
  
}