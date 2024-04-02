terraform {
  required_version = ">= 1.0.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "latest"
    }
  }
}

resource "null_resource" "null_resource" {
}
