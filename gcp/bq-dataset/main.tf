terraform {
  required_version  = "=0.12.3"
}

resource "random_id" "id" {
  byte_length = 8
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "env0_test_${random_id.id.dec}"
}
