provider "google" {
    credentials = var.key_json
    project = "env0project"
    region = "us-central1"
    zone = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
    name = "terraform-instance2"
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
