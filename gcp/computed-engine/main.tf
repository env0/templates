variable "key_json" { default = "{}"}

provider "google" {
    credentials = file("clientLibraryConfig-yossi-test-oidc.json") # file("env0_credential_configuration.json")
    project = "env0project"
    region = "us-central1"
    zone = "us-central1-c"
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "google_compute_network" "vpc_network" {
    name = "yossi-terraform-network-${random_string.random.result}"
}

resource "google_compute_instance" "vm_instance" {
    name = "yossi-terraform-instance-${random_string.random.result}"
    machine_type = "f1-micro"
    zone = "us-central1-c"
    boot_disk {
        initialize_params {
            image = "centos-cloud/centos-7"
        }
    }

    network_interface {
        network = google_compute_network.vpc_network.name
        access_config {
        }
    }
}
