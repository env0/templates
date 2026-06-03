terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

variable "expected_client_id" {
  description = "The client id terraform is expected to authenticate as"
}

data "azurerm_client_config" "current" {}

resource "terraform_data" "validate_client_id" {
  lifecycle {
    precondition {
      condition     = data.azurerm_client_config.current.client_id == var.expected_client_id
      error_message = "Authenticated as client_id '${data.azurerm_client_config.current.client_id}', expected '${var.expected_client_id}'."
    }
  }
}

output "authenticated_client_id" {
  value = data.azurerm_client_config.current.client_id
}
