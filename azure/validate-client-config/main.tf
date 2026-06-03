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

data "azurerm_subscription" "current" {}

resource "terraform_data" "validate_authenticated_identity" {
  input = data.azurerm_subscription.current.subscription_id

  lifecycle {
    precondition {
      condition     = data.azurerm_client_config.current.client_id == var.expected_client_id
      error_message = "Authenticated as client_id '${data.azurerm_client_config.current.client_id}', expected '${var.expected_client_id}'."
    }

    precondition {
      condition     = data.azurerm_subscription.current.tenant_id == data.azurerm_client_config.current.tenant_id
      error_message = "Subscription tenant '${data.azurerm_subscription.current.tenant_id}' does not match the authenticated tenant '${data.azurerm_client_config.current.tenant_id}'."
    }
  }
}

output "authenticated_client_id" {
  value = data.azurerm_client_config.current.client_id
}

output "subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}
