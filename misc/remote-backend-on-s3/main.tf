provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "yariv-remote-backend-force-unlock-check"
    key = "remote-backend"
    region = "us-east-1"
  }
}

resource "null_resource" "null" {
}
