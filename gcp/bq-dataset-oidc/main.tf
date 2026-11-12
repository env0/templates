terraform {
  required_version = "=0.14.11"
}

# env0 writes the GCP_OIDC credential's external-account config to this file at deploy time.
provider "google" {
  credentials = file("env0_credential_configuration.json")
}

resource "random_id" "id" {
  byte_length = 8
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "env0_test_${random_id.id.dec}"
}
