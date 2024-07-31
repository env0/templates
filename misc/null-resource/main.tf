resource "aws_s3_bucket" "example" {
  bucket = "bucket-for-pr16566"

  tags = {
    Name        = "bucket for pr16566"
    Environment = "bla bla"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
