resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-tomer"

  tags = {
    Name        = "Version 1 Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
