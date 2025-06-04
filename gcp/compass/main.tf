provider "google" {
  project = "env0project"
  zone    = "us-central1-a" 
}


#create bucket
resource "google_storage_bucket" "buc" {
  name          = "my-name-tomer-bucket-test"
  location      = "US"
}

