terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  assume_role_with_web_identity {
    role_arn                = "arn:aws:iam::170412844252:role/built-in-oidc-test-role"
    session_name            = "env0_OIDC_session"
    web_identity_token_file = "web-identity-token.txt"
  }
}
