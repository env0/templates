terraform {
  backend "gcs" {
    bucket  = "env0-gcp-backend-state-bucket"
    prefix  = "container_cluster_states"
  }
}

# Copied from https://www.terraform.io/docs/providers/google/r/container_node_pool.html

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  resource_labels = {
    my_label_1 = "label-1"
    my_label_1a = "label-1a"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      my_label_2 = "label-2"
    }
  }
}
