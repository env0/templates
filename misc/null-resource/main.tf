resource "null_resource" "null" {
}
terraform {
  required_providers {
    aws        = "~> 3.70.0"
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "random_string" "random" {
  length = "16"
  special = "false"
  min_lower = "16"
}

resource "aws_s3_bucket" "yaron" {
  bucket = "yaron-tessst-${random_string.random.result}"
  force_destroy = true
}