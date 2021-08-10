resource "aws_s3_bucket" "sic-bucket" {
  bucket = "s3-sic-app"
  acl    = "public-read"

  tags = {
    Name = "Travel Itinerary App Bucket"
  }
}