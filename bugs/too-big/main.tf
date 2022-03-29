resource "null_resource" "yoshhiig" {
  count = 21900
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  count = 123000
  tags = {
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b[0].id
  acl    = "private"
}
