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

resource "aws_s3_bucket" "website_bucket" {
  bucket = "env0-s3-${random_string.random.result}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Delay before PutBucketPolicy due to API race condition
resource "null_resource" "delay" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership,
    aws_s3_bucket_public_access_block.bucket_public_access_block
  ]

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  depends_on = [null_resource.delay]

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Public-Access",
  "Statement": [
    {
      "Sid": "Allow-Public-Access-To-Bucket",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "../index.html"
  content_type = "text/html"
}
