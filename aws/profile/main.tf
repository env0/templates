terraform {
  backend "s3" {
    bucket  = "bucket-in-custom-profile"
    key     = "profile-state"
    region  = "us-east-1"
    profile = "custom-profile"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "bucket-in-default-profile"
  acl    = "private"
}
