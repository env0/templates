resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-tomer-demo"

  tags = {
    Name        = "Version 2 Bucket"
    Environment = "Dev2"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
