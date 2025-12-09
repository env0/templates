provider "random" {}

resource "random_string" "random" {
  length    = 16
  special   = false
  min_lower = 16
}

undefined

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
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

# Adding delay because PutBucketPolicy API below can fail due to race condition with the removal of public access block
# This is a recommendation by AWS support :(
resource "null_resource" "delay" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership,
    aws_s3_bucket_public_access_block.bucket_public_access_block
  ]

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

undefined

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}
