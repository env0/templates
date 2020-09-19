provider "aws" {
  version = "~> 2.0"
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
  acl    = "public-read"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = "${aws_s3_bucket.website_bucket.id}"

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

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.website_bucket.bucket}"
  key    = "index.html"
  source = "../index.html"
  content_type = "text/html"
}
