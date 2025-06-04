variable "zone" {
  description = "The GCP zone to deploy resources in (e.g., us-central1-a)."
  type        = string
  default     = "us-central1-a"
  
}

variable "region" {
  description = "The GCP region to deploy resources in (e.g., us-central1)."
  type        = string
  default     = "us-central1"
  
}

variable "project_id" {
  description = "The GCP project ID."
  type        = string
  default     = "env0project" // Replace with your actual project ID
}

// Define the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

// 1. VPC Network
resource "google_compute_network" "main_vpc" {
  name                    = "tomer-compass-test-main-vpc-network"
  auto_create_subnetworks = false // We'll create a custom subnetwork
  routing_mode            = "REGIONAL"
  description             = "Main VPC network for common GCP resources."
}

// 2. Subnetwork
resource "google_compute_subnetwork" "main_subnet" {
  name          = "tomer-compass-test-main-subnet"
  ip_cidr_range = "10.0.0.0/20"
  region        = var.region
  network       = google_compute_network.main_vpc.id
  description   = "Subnetwork for the main VPC."
}

// 3. Firewall Rule (Allow HTTP/HTTPS/SSH)
resource "google_compute_firewall" "allow_web_ssh" {
  name    = "tomer-compass-test-allow-web-ssh"
  network = google_compute_network.main_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"] // Be more restrictive in production
  description   = "Allow HTTP, HTTPS, and SSH access."
}

// 4. VM Instance (e.g., a simple Nginx server)
resource "google_compute_instance" "nginx_instance" {
  name         = "tomer-compass-test-nginx-instance"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.main_vpc.id
    subnetwork = google_compute_subnetwork.main_subnet.id
    access_config { // Assign an external IP for SSH/web access
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = ["http-server", "https-server", "ssh"]
  description = "A basic VM instance running Nginx."
}

// 5. GKE Cluster
resource "google_container_cluster" "primary_gke_cluster" {
  name               = "tomer-compass-test-primary-gke-cluster"
  location           = var.region // Use region for regional clusters
  initial_node_count = 1
  network            = google_compute_network.main_vpc.id
  subnetwork         = google_compute_subnetwork.main_subnet.id

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  release_channel {
    channel = "REGULAR"
  }

  // Enable private cluster for better security (optional, requires more network setup)
  // private_cluster_config {
  //   enable_private_nodes    = true
  //   enable_private_endpoint = false // Set to true if you want to access API endpoint privately
  //   master_ipv4_cidr_block  = "172.16.0.0/28"
  // }

  depends_on = [
    google_compute_subnetwork.main_subnet,
    google_compute_network.main_vpc
  ]
  description = "Primary GKE cluster for containerized applications."
}

// 6. Cloud SQL Instance (PostgreSQL example)
resource "google_sql_database_instance" "main_sql_instance" {
  name             = "tomer-compass-test-main-sql-instance"
  database_version = "POSTGRES_14"
  region           = var.region
  settings {
    tier = "db-f1-micro" // Smallest tier for demonstration
    ip_configuration {
      ipv4_enabled = true
      // authorized_networks {
      //   value = "0.0.0.0/0" // Be more restrictive in production
      // }
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    // Private IP configuration (recommended for production)
    // private_network = google_compute_network.main_vpc.id
  }
}

// 7. GCS Bucket
resource "google_storage_bucket" "main_storage_bucket" {
  name          = "tomer-compass-test-${var.project_id}-main-storage-bucket" // Bucket names must be globally unique
  location      = "US" // Or choose a multi-region like "US" or "EU"
  force_destroy = true // Allows deleting bucket with contents (use with caution!)
  uniform_bucket_level_access = true
}

// 8. BigQuery Dataset
resource "google_bigquery_dataset" "main_bq_dataset" {
  dataset_id                  = "tomer_compass_test_main_dataset" // Dataset IDs must be lowercase and can't have hyphens
  friendly_name               = "Tomer Compass Test Main BigQuery Dataset"
  description                 = "Dataset for analytical data."
  location                    = "US"
  default_table_expiration_ms = 3600000 // 1 hour
  access {
    role          = "OWNER"
    user_by_email = "service-${var.project_id}@gcp-sa-bigquery.iam.gserviceaccount.com" // BigQuery service account
  }
}

// 9. Cloud Function (HTTP triggered example)
resource "google_storage_bucket_object" "cloud_function_source" {
  name   = "tomer-compass-test-function-source.zip"
  bucket = google_storage_bucket.main_storage_bucket.name
  source = "function-source.zip" // Path to your local zip file with function code
  // For a quick test, you can create a dummy zip file:
  // echo 'exports.helloWorld = (req, res) => { res.send("Hello, World!"); };' > index.js
  // zip function-source.zip index.js
}

resource "google_cloudfunctions_function" "hello_world_function" {
  name        = "tomer-compass-test-hello-world-function"
  runtime     = "nodejs16"
  entry_point = "helloWorld"
  region      = var.region
  source_archive_bucket = google_storage_bucket.main_storage_bucket.name
  source_archive_object = google_storage_bucket_object.cloud_function_source.name
  trigger_http          = true
  available_memory_mb   = 128
  description = "A simple HTTP-triggered Cloud Function."

  depends_on = [
    google_storage_bucket_object.cloud_function_source
  ]
}

// Allow unauthenticated invocations for the Cloud Function (for testing)
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.hello_world_function.project
  region         = google_cloudfunctions_function.hello_world_function.region
  cloud_function = google_cloudfunctions_function.hello_world_function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers" // Be more restrictive in production
}

// 10. Cloud Run Service
resource "google_cloud_run_service" "hello_cloud_run" {
  name     = "tomer-compass-test-hello-cloud-run"
  location = var.region

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello" // Example public image
      }
    }
  }

  traffic {
    percent = 100
  }
}

// Allow unauthenticated access to Cloud Run service
resource "google_cloud_run_service_iam_member" "cloud_run_public_access" {
  location = google_cloud_run_service.hello_cloud_run.location
  project  = google_cloud_run_service.hello_cloud_run.project
  service  = google_cloud_run_service.hello_cloud_run.name
  role     = "roles/run.invoker"
  member   = "allUsers" // Be more restrictive in production
}

// 11. Cloud Pub/Sub Topic
resource "google_pubsub_topic" "main_pubsub_topic" {
  name        = "tomer-compass-test-main-pubsub-topic"
}

// 12. Cloud Build Trigger (e.g., for a GitHub repository)
// Note: This requires connecting a repository to Cloud Build manually or via another resource.
// This example assumes a connected GitHub repository.
resource "google_cloudbuild_trigger" "github_trigger" {
  name        = "tomer-compass-test-github-repo-build-trigger"
  description = "Trigger for building from a GitHub repository."

  github {
    owner = "your-github-org" // Replace with your GitHub organization/user
    name  = "your-repo-name"  // Replace with your repository name
    push {
      branch = "^main$"
    }
  }

  filename = "cloudbuild.yaml" // Path to your Cloud Build configuration file
  disabled = true // Set to false to enable the trigger
}

// 13. IAM Service Account
resource "google_service_account" "app_service_account" {
  account_id   = "tomer-compass-test-app-sa" // Account ID must be 6-30 characters, lowercase letters, numbers, hyphens.
  display_name = "Tomer Compass Test Service Account for Applications"
  description  = "Service account used by various applications."
}

// 14. Cloud Scheduler Job
resource "google_cloud_scheduler_job" "daily_cron_job" {
  name        = "tomer-compass-test-daily-cron-job"
  description = "A daily cron job to trigger a Pub/Sub message."
  schedule    = "0 0 * * *" // Every day at midnight UTC
  time_zone   = "America/Los_Angeles"

  pubsub_target {
    topic_name = google_pubsub_topic.main_pubsub_topic.id
    data       = base64encode("Hello from Cloud Scheduler!")
  }
}

// 15. Secret Manager Secret
resource "google_secret_manager_secret" "api_key_secret" {
  secret_id = "tomer-compass-test-my-api-key"
  labels = {
    environment = "development"
  }
  replication {
    auto {}
  }
}

// Add a secret version with some dummy data
resource "google_secret_manager_secret_version" "api_key_secret_version" {
  secret      = google_secret_manager_secret.api_key_secret.id
  secret_data = "super-secret-api-key-123" // Replace with actual sensitive data
}

// 16. Cloud Load Balancing Backend Service (HTTP example)
# resource "google_compute_backend_service" "web_backend_service" {
#   name        = "tomer-compass-test-web-backend-service"
#   protocol    = "HTTP"
#   port_name   = "http"
#   timeout_sec = 10

#   health_checks = [google_compute_health_check.http_health_check.id]
#   description = "Backend service for web traffic."
# }

# resource "google_compute_health_check" "http_health_check" {
#   name               = "tomer-compass-test-http-health-check"
#   check_interval_sec = 5
#   timeout_sec        = 5
#   unhealthy_threshold = 2
#   healthy_threshold  = 2
#   description = "HTTP health check for web backend."
# }

// 17. Cloud Load Balancing Forwarding Rule (External HTTP Load Balancer)
// Requires a global IP address
resource "google_compute_global_address" "web_lb_ip" {
  name = "tomer-compass-test-web-lb-ip"
  description = "Global IP address for the web load balancer."
}

resource "google_compute_target_http_proxy" "web_http_proxy" {
  name    = "tomer-compass-test-web-http-proxy"
  url_map = google_compute_url_map.web_url_map.id
  description = "HTTP proxy for the web load balancer."
}

# resource "google_compute_url_map" "web_url_map" {
#   name            = "tomer-compass-test-web-url-map"
#   default_service = google_compute_backend_service.web_backend_service.id
#   description = "URL map for the web load balancer."
# }

resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
  name        = "tomer-compass-test-web-forwarding-rule"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.web_http_proxy.id
  ip_address  = google_compute_global_address.web_lb_ip.id
  load_balancing_scheme = "EXTERNAL"
  description = "Global forwarding rule for the web load balancer."
}

// 18. Cloud Router
resource "google_compute_router" "main_router" {
  name    = "tomer-compass-test-main-router"
  region  = var.region
  network = google_compute_network.main_vpc.id
  description = "Cloud Router for the main VPC."
}

// 19. Cloud Bigtable Instance
resource "google_bigtable_instance" "main_bigtable_instance" {
  name        = "tomer-compass-test-main-bigtable-instance"
  cluster {
    cluster_id   = "tomer-compass-test-main-bigtable-cluster"
    zone         = var.zone
    num_nodes    = 1 // Minimum for development
    storage_type = "SSD"
  }
  deletion_protection = false // Set to true in production
}

// 20. Firestore Database (for non-default databases or configuring default)
// Note: A default Firestore database is usually created automatically when you enable Firestore.
// This resource can be used to manage a non-default database or configure the default one.
// If you already have a default database, you might need to import it or adjust this resource.
resource "google_firestore_database" "main_firestore_database" {
  name     = "(default)" // To manage the default database, this must remain "(default)"
  location_id = var.region // Ensure this matches your project's default Firestore location
  type     = "FIRESTORE_NATIVE" // Or "DATSTORE_MODE"
  app_engine_integration_mode = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
}



// outputs.tf (Optional, but good practice to show important info)
output "vm_instance_external_ip" {
  description = "The external IP address of the Nginx VM instance."
  value       = google_compute_instance.nginx_instance.network_interface[0].access_config[0].nat_ip
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = google_container_cluster.primary_gke_cluster.endpoint
}

output "gcs_bucket_name" {
  description = "The name of the main GCS bucket."
  value       = google_storage_bucket.main_storage_bucket.name
}

output "cloud_function_url" {
  description = "The URL of the Hello World Cloud Function."
  value       = google_cloudfunctions_function.hello_world_function.https_trigger_url
}

output "cloud_run_url" {
  description = "The URL of the Hello Cloud Run service."
  value       = google_cloud_run_service.hello_cloud_run.status[0].url
}

output "web_lb_ip_address" {
  description = "The IP address of the external HTTP Load Balancer."
  value       = google_compute_global_address.web_lb_ip.address
}
