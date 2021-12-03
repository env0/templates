terraform {
  required_version  = "=0.14.11"
}

resource "random_id" "id" {
  byte_length = 8
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "env0_test_${random_id.id.dec}"
}
