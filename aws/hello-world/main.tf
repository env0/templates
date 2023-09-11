provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
  assume_role_with_web_identity {
    role_arn                = "arn:aws:iam::170412844252:role/yossi-test-oidc-role"
    session_name            = "env0_OIDC_session"
    web_identity_token_file = "web-identity-token.txt"
  }
}

terraform {
  required_version = ">= 0.13"
}
