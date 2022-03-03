terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

data "aws_secretsmanager_secret" "secret" {
  name = var.secret_name
}

resource "null_resource" "null" {
  triggers = {
    cluster_instance_ids = join(",", keys(data.aws_secretsmanager_secret.secret.tags))
  }
}

variable "secret_name" {

}
