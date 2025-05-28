provider "google" {
  project = "env0project"
  zone    = "us-central1-a"
}


#create bucket
resource "google_storage_bucket" "bucket" {
  name          = "my-name-tomer-hamelech2"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

