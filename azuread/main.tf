# Configure Terraform
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.1.0"  # 👈 This allows upgrades
    }
  }
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = "00000000-0000-0000-0000-000000000000"
}

