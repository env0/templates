##### GCP

variable "key_json" { default = "{}"}

provider "google" {
    credentials = file("env0_credential_configuration.json")
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

##### AZURE

# Configure the Microsoft Azure Provider
provider "azurerm" {
  version = "3.28.0"
  features {}
}
# Vars

variable "client_name" {
  default = "Socks"
}

variable "client_logo_url" {
  default = "https://www.jojomamanbebe.com/media/catalog/product/cache/1/image/1000x/cc44d3b39965d3efd15a8158cb2fdfb4/d/2/d2617redc4.jpg"
}

# Resources

resource "azurerm_resource_group" "group" {
  name     = "env0${random_string.random.result}-${var.client_name}-group"
  location = "northeurope"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "${azurerm_resource_group.group.name}-plan"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  os_type             = "Linux"

  sku_name = "P1v2"
}

resource "azurerm_app_service" "dockerapp" {
  name                = "${azurerm_resource_group.group.name}-app"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  app_service_plan_id = azurerm_service_plan.appserviceplan.id

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    CLIENT_NAME                         = "${var.client_name}"
    CLIENT_LOGO_URL                     = "${var.client_logo_url}"
  }

  site_config {
    linux_fx_version = "DOCKER|env0/demo-container:latest"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Outputs 

output "default_site_hostname" {
  value = azurerm_app_service.dockerapp.default_site_hostname
}
