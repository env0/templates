variable "key_json" { default = "{}"}

provider "google" {
    credentials = file("env0-config.json")
    project = "env0project"
    region = "us-central1"
    zone = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
    name = "yossi-terraform-network"
}

resource "google_compute_instance" "vm_instance" {
    name = "yossi-terraform-instance2"
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