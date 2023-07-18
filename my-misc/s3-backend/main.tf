terraform {
  backend "s3" {
    bucket = "alon-noga-test-bucket"
    key = "remote-backend"
    region = "us-east-1"
  }
}

resource "null_resource" "null" {
}
