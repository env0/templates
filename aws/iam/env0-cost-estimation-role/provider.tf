locals {
    terraform-git-repo = "terraform-aws-infra"
    }

provider "aws" {
  region     = var.aws_region

  default_tags {
    tags = {
      Environment         = var.environment
      Application         = var.application
      Department          = var.department
      Orchestration       = var.orchestration
    }
  }
}
