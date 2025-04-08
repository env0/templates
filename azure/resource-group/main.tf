terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
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
