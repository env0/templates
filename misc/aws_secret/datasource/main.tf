terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


data "aws_secretsmanager_secret" "secret" {
  name = "liron-example-name-1112"
}


resource "null_resource" "null" {
  triggers = {
    cluster_instance_ids = join(",", keys(data.aws_secretsmanager_secret.secret.tags))
  }
}
