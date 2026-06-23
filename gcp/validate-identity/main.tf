terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

# env0 writes the GCP_OIDC credential's external-account config to this file at deploy time
# (alongside the token file it references); point the provider at it as env0's GCP OIDC docs instruct.
provider "google" {
  credentials = file("env0_credential_configuration.json")
}

# Reading the access token forces the full external-account exchange: the env0 OIDC token is
# exchanged at the WIF provider (which accepts only this credential's single audience) and then used
# to impersonate the service account. A non-empty token therefore proves the deploy authenticated
# through the correct provider audience — the v1/v2 discriminator. (google_client_openid_userinfo
# returns a null email for impersonated service accounts, so it can't assert the identity here; the
# WIF provider's single allowed audience is what makes each token-version test meaningful.)
data "google_client_config" "current" {}

resource "terraform_data" "validate_authenticated" {
  lifecycle {
    precondition {
      condition     = data.google_client_config.current.access_token != ""
      error_message = "GCP authentication failed: no access token was obtained from the Workload Identity Federation credential exchange."
    }
  }
}

output "authenticated_project" {
  value = data.google_client_config.current.project
}
