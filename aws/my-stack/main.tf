provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
}

provider "random" {}

resource "random_string" "random" {
  length = "16"
  special = "false"
  min_lower = "16"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "env0-s3-a-${random_string.random.result}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
