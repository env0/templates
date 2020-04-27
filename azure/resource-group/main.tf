provider "azurerm" {
  version = "~> 1.15"
}

resource "random_string" "random" {
  length = 8
  special = false
  upper = false
}

resource "azurerm_resource_group" "group" {
  name     = "env0-${random_string.random.result}-group"
  location = "northeurope"
}
