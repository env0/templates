terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {}

variable "expected_service_account" {
  description = "Substring expected in the email of the identity terraform authenticates as (e.g. the impersonated service account)"
}

data "google_client_openid_userinfo" "me" {}

resource "terraform_data" "validate_authenticated_identity" {
  input = data.google_client_openid_userinfo.me.email

  lifecycle {
    precondition {
      condition     = strcontains(data.google_client_openid_userinfo.me.email, var.expected_service_account)
      error_message = "Authenticated as '${data.google_client_openid_userinfo.me.email}', expected the email to contain '${var.expected_service_account}'."
    }
  }
}

output "authenticated_email" {
  value = data.google_client_openid_userinfo.me.email
}
