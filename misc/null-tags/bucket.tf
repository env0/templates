resource "aws_s3_bucket" "should_have_tags" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name = "My bucket"
  }
}
