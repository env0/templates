terraform {
  required_version = ">= 1.0.0"

  required_providers {
    null        = "~> 3.2.1"
  }
}

resource "null_resource" "null_resource" {
}
