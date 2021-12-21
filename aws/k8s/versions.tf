terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws        = "~> 3.68.0"
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
