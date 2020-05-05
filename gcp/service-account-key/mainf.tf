terraform {
  required_version  = ">=0.12.3"
}

provider "google" {
  version = ">=3.0.0"
  project = var.project
}

resource "google_service_account" "account" {
  account_id   = var.account_id
  display_name = var.account_display_name
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}