# Configure the Microsoft Azure Provider
provider "azurerm" {
  version = "3.28.0"
  features {}

  subscription_id = "b48787a1-7145-425f-99af-62cde6c50e31"
  client_id       = "e701f066-c866-4321-9adc-1089dcae9ff5"
  tenant_id       = "f3450d00-1632-47b8-ab1b-c7c1617ef6cd"
  use_oidc        = true
}
# Vars

variable "client_name" {
  default = "Socks"
}

variable "client_logo_url" {
  default = "https://www.jojomamanbebe.com/media/catalog/product/cache/1/image/1000x/cc44d3b39965d3efd15a8158cb2fdfb4/d/2/d2617redc4.jpg"
}

# Resources

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

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

