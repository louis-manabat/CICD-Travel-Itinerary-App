resource "aws_s3_bucket" "sic-bucket" {
  bucket = "s3-sic-app"
  acl    = "public-read"

  tags = {
    Name = "Travel Itinerary App Bucket"
  }
}

resource "aws_s3_bucket_object" "upload-logo" {
  bucket = aws_s3_bucket.sic-bucket.id
  key    = "profile"
  acl    = "public-read"
  source = "../src/logo.png"
  etag   = filemd5("../src/logo.png")
}