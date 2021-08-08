resource "aws_dynamodb_table" "ddb-user-table" {
  name           = "users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "email"

  attribute {
    name = "email"
    type = "S"
  }

  tags = {
    Name = "Simple Travel Itinerary App - User"
  }
}

resource "aws_dynamodb_table" "ddb-locations-table" {
  name           = "locations"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "city"
  range_key      = "country"

  attribute {
    name = "city"
    type = "S"
  }

  attribute {
    name = "country"
    type = "S"
  }

  tags = {
    Name = "Simple Travel Itinerary App - Locations"
  }
}