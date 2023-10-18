provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
}

terraform {
  required_version = ">= 0.13"
}

#terraform {
#  required_version = ">= 0.13"
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 4.0"
#    }
#  }
#}

# Configure the AWS Provider
#provider "aws" {
#  version = "~> 4.0"
#  region  = "us-east-1"

#  #assume_role_with_web_identity {
#  #  role_arn                = "arn:aws:iam::170412844252:role/yossi-test-oidc-aws"
#  #  session_name            = "env0_OIDC_session"
#  #  web_identity_token_file = "web-identity-token.txt"
#  }
#}
