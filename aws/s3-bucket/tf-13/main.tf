provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  required_version = "0.13.3"
}

module "s3" {
  source = "../s3/"
}
