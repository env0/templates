terraform {
  required_version = "~>0.15.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

