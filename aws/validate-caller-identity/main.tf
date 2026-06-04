terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {}

variable "expected_arn" {
  description = "Substring expected in the ARN terraform authenticates as (e.g. the assumed-role ARN)"
}

data "aws_caller_identity" "current" {}

resource "terraform_data" "validate_authenticated_identity" {
  input = data.aws_caller_identity.current.arn

  lifecycle {
    precondition {
      condition     = strcontains(data.aws_caller_identity.current.arn, var.expected_arn)
      error_message = "Authenticated as '${data.aws_caller_identity.current.arn}', expected the ARN to contain '${var.expected_arn}'."
    }
  }
}

output "authenticated_arn" {
  value = data.aws_caller_identity.current.arn
}
